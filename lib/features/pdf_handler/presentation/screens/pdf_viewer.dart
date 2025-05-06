import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends ConsumerWidget {
  const PdfViewerScreen({super.key});

  // Path to your sample PDF in assets
  final String assetPdfPath = 'assets/pdfs/sample.pdf';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SfPdfViewer.asset(
      assetPdfPath,
      onDocumentLoadFailed: (details) {
        // Handle PDF loading errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading PDF: ${details.description}')),
        );
      },
      // You can customize the viewer with various options
      // Example:
      // canShowScrollHead: true,
      // canShowScrollStatus: true,
      pageLayoutMode: PdfPageLayoutMode.single,
      // Add a key if you need to control the viewer instance programmatically
      // key: _pdfViewerKey,
    );

    // Or show a loading indicator while checking if asset exists, etc.
    // For now, directly loading.
  }
}