import 'package:aisign_project/features/pdf_handler/domain/enums/annotation_enum.dart';
import 'package:aisign_project/features/pdf_handler/domain/models/annotation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentToolProvider = StateProvider<AnnotationTool>((ref) {
  return AnnotationTool.none;
});

final selectedColorProvider = StateProvider<Color>((ref) {
  return Colors.red;
});

// Provider for stroke width
final strokeWidthProvider = StateProvider<double>((ref) {
  return 2.0;
});

class AnnotationState {
  final AnnotationTool tool;
  final Color color;
  final double strokeWidth;
  final List<List<Offset>> strokes; // completed
  final List<Offset> current;        // in-progress

  AnnotationState({
    this.tool = AnnotationTool.none,
    this.color = Colors.red,
    this.strokeWidth = 2.0,
    List<List<Offset>>? strokes,
    List<Offset>? current,
  })  : strokes = strokes ?? [],
        current = current ?? [];
}

final annotationsProvider = StateNotifierProvider<AnnotationsNotifier, List<PdfAnnotation>>((ref) {
  return AnnotationsNotifier();
});

class AnnotationsNotifier extends StateNotifier<List<PdfAnnotation>> {
  AnnotationsNotifier() : super([]);

  void addAnnotation(PdfAnnotation annotation) {
    state = [...state, annotation];
  }

  void clearAnnotations() {
    state = [];
  }
}
