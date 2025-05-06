import 'package:aisign_project/features/pdf_handler/domain/enums/annotation_enum.dart';
import 'package:flutter/material.dart';

class PdfAnnotation {
  final AnnotationTool type;
  final Color color;
  final double strokeWidth;
  final List<Offset> points; // For ink annotations
  final Rect? rect; // For rectangle annotations
  final String? text; // For text annotations
  final Offset? position; // Position for text annotations

  PdfAnnotation({
    required this.type,
    required this.color,
    required this.strokeWidth,
    this.points = const [],
    this.rect,
    this.text,
    this.position,
  });
}