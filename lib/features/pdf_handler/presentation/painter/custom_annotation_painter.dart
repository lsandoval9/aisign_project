import 'dart:ui';

import 'package:aisign_project/features/pdf_handler/domain/models/annotation_model.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/enums/annotation_enum.dart';

class AnnotationPainter extends CustomPainter {
  final List<PdfAnnotation> annotations;
  final List<Offset> currentPoints;
  final Offset? startPoint;
  final Offset? endPoint;
  final AnnotationTool currentTool;
  final Color color;
  final double strokeWidth;

  AnnotationPainter({
    required this.annotations,
    required this.currentPoints,
    required this.startPoint,
    required this.endPoint,
    required this.currentTool,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw existing annotations
    for (var annotation in annotations) {
      switch (annotation.type) {
        case AnnotationTool.ink:
          _drawInk(canvas, annotation.points, annotation.color, annotation.strokeWidth);
          break;
        case AnnotationTool.highlighter:
          _drawHighlighter(canvas, annotation.points, annotation.color, annotation.strokeWidth);
          break;
        case AnnotationTool.rectangle:
          if (annotation.rect != null) {
            _drawRectangle(canvas, annotation.rect!, annotation.color, annotation.strokeWidth);
          }
          break;
        case AnnotationTool.text:
          if (annotation.text != null && annotation.position != null) {
            _drawText(canvas, annotation.text!, annotation.position!, annotation.color);
          }
          break;
        case AnnotationTool.none:
          break;
      }
    }

    // Draw current annotation being created
    switch (currentTool) {
      case AnnotationTool.ink:
        _drawInk(canvas, currentPoints, color, strokeWidth);
        break;
      case AnnotationTool.highlighter:
        _drawHighlighter(canvas, currentPoints, color, strokeWidth * 3);
        break;
      case AnnotationTool.rectangle:
        if (startPoint != null && endPoint != null) {
          _drawRectangle(
              canvas,
              Rect.fromPoints(startPoint!, endPoint!),
              color,
              strokeWidth
          );
        }
        break;
      case AnnotationTool.text:
      case AnnotationTool.none:
        break;
    }
  }

  void _drawInk(Canvas canvas, List<Offset> points, Color color, double strokeWidth) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  void _drawHighlighter(Canvas canvas, List<Offset> points, Color color, double strokeWidth) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  void _drawRectangle(Canvas canvas, Rect rect, Color color, double strokeWidth) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect, paint);
  }

  void _drawText(Canvas canvas, String text, Offset position, Color color) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(color: color, fontSize: 16),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant AnnotationPainter oldDelegate) {
    return oldDelegate.annotations != annotations ||
        oldDelegate.currentPoints != currentPoints ||
        oldDelegate.startPoint != startPoint ||
        oldDelegate.endPoint != endPoint ||
        oldDelegate.currentTool != currentTool ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}