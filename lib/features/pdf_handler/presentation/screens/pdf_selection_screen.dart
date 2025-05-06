import 'dart:io';

import 'package:aisign_project/features/pdf_handler/domain/enums/annotation_enum.dart';
import 'package:aisign_project/features/pdf_handler/domain/models/annotation_model.dart';
import 'package:aisign_project/features/pdf_handler/presentation/painter/custom_annotation_painter.dart';
import 'package:aisign_project/features/pdf_handler/presentation/providers/annotation_providers.dart';
import 'package:aisign_project/features/pdf_handler/presentation/widgets/annotation_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends ConsumerStatefulWidget {
  final String pdfPath;

  const PdfViewerScreen({
    super.key,
    required this.pdfPath,
  });

  @override
  ConsumerState<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends ConsumerState<PdfViewerScreen> {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  // For handling drawing
  List<Offset> _currentPoints = [];
  Offset? _startPoint;
  Offset? _endPoint;
  TextEditingController _textController = TextEditingController();
  Offset? _textPosition;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _handlePointerDown(PointerDownEvent event) {
    final tool = ref.read(currentToolProvider);

    if (tool == AnnotationTool.none) return;

    if (tool == AnnotationTool.ink || tool == AnnotationTool.highlighter) {
      setState(() {
        _currentPoints = [event.localPosition];
      });
    } else if (tool == AnnotationTool.rectangle) {
      setState(() {
        _startPoint = event.localPosition;
        _endPoint = event.localPosition;
      });
    } else if (tool == AnnotationTool.text) {
      setState(() {
        _textPosition = event.localPosition;
      });
      _showTextInputDialog();
    }
  }

  void _handlePointerMove(PointerMoveEvent event) {
    final tool = ref.read(currentToolProvider);

    if (tool == AnnotationTool.none) return;

    if (tool == AnnotationTool.ink || tool == AnnotationTool.highlighter) {
      setState(() {
        _currentPoints.add(event.localPosition);
      });
    } else if (tool == AnnotationTool.rectangle) {
      setState(() {
        _endPoint = event.localPosition;
      });
    }
  }

  void _handlePointerUp(PointerUpEvent event) {
    final tool = ref.read(currentToolProvider);
    final color = ref.read(selectedColorProvider);
    final strokeWidth = ref.read(strokeWidthProvider);

    if (tool == AnnotationTool.none) return;

    if (tool == AnnotationTool.ink || tool == AnnotationTool.highlighter) {
      if (_currentPoints.isNotEmpty) {
        ref.read(annotationsProvider.notifier).addAnnotation(
          PdfAnnotation(
            type: tool,
            color: color,
            strokeWidth: tool == AnnotationTool.highlighter ? strokeWidth * 3 : strokeWidth,
            points: List.from(_currentPoints),
          ),
        );
      }
      setState(() {
        _currentPoints = [];
      });
    } else if (tool == AnnotationTool.rectangle) {
      if (_startPoint != null && _endPoint != null) {
        final rect = Rect.fromPoints(_startPoint!, _endPoint!);
        ref.read(annotationsProvider.notifier).addAnnotation(
          PdfAnnotation(
            type: tool,
            color: color,
            strokeWidth: strokeWidth,
            rect: rect,
          ),
        );
      }
      setState(() {
        _startPoint = null;
        _endPoint = null;
      });
    }
  }

  void _showTextInputDialog() {
    _textController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Text Annotation'),
        content: TextField(
          controller: _textController,
          decoration: InputDecoration(hintText: 'Enter text'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_textController.text.isNotEmpty && _textPosition != null) {
                ref.read(annotationsProvider.notifier).addAnnotation(
                  PdfAnnotation(
                    type: AnnotationTool.text,
                    color: ref.read(selectedColorProvider),
                    strokeWidth: ref.read(strokeWidthProvider),
                    text: _textController.text,
                    position: _textPosition,
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final File pdfFile = File(widget.pdfPath);
    final currentTool = ref.watch(currentToolProvider);
    final annotations = ref.watch(annotationsProvider);

    if (!pdfFile.existsSync()) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("PDF file not found or path is invalid.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(annotationsProvider.notifier).clearAnnotations();
            },
            tooltip: 'Clear all annotations',
          ),
        ],
      ),
      body: Stack(
        children: [
          // PDF Viewer
          SfPdfViewer.file(
            pdfFile,
            key: _pdfViewerKey,
            controller: _pdfViewerController,
            onDocumentLoadFailed: (details) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error loading PDF: ${details.description}')),
              );
            },
            pageLayoutMode: PdfPageLayoutMode.single,
          ),

          // Listener for drawing
          Positioned.fill(
            child: Listener(
              onPointerDown: _handlePointerDown,
              onPointerMove: _handlePointerMove,
              onPointerUp: _handlePointerUp,
              child: IgnorePointer(
                ignoring: currentTool == AnnotationTool.none,
                child: CustomPaint(
                  painter: AnnotationPainter(
                    annotations: annotations,
                    currentPoints: _currentPoints,
                    startPoint: _startPoint,
                    endPoint: _endPoint,
                    currentTool: currentTool,
                    color: ref.watch(selectedColorProvider),
                    strokeWidth: ref.watch(strokeWidthProvider),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnnotationToolbar(
        selectedTool: currentTool,
        selectedColor: ref.watch(selectedColorProvider),
        strokeWidth: ref.watch(strokeWidthProvider),
        onToolSelected: (tool) {
          ref.read(currentToolProvider.notifier).state = tool;
        },
        onColorSelected: (color) {
          ref.read(selectedColorProvider.notifier).state = color;
        },
        onStrokeWidthChanged: (width) {
          ref.read(strokeWidthProvider.notifier).state = width;
        },
      ),
    );
  }
}