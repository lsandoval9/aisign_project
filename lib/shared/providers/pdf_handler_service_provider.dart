import 'package:aisign_project/shared/services/pdf_handler_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// this should use an interface instead of a concrete class
final pdfHandlerServiceProvider = Provider<PdfHandlerService>((ref) {
  return PdfHandlerService();
});