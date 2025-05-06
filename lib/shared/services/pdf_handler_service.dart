import 'dart:io'; // Required for File operations
import 'dart:typed_data'; // Required for Uint8List
import 'package:aisign_project/shared/errors/base/failure_base.dart';
import 'package:aisign_project/shared/errors/pdf_errors.dart';
import 'package:file_picker/file_picker.dart';


// this should implement an interface to inject it using riverpod but lets make it shortly
class PdfHandlerService {

  static const List<int> _pdfMagicBytes = [0x25, 0x50, 0x44, 0x46, 0x2D];

  Future<String?> getFilePath() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: false, // Don't load file data into memory yet
        withReadStream: true, // Better for reading header bytes
      );

      if (result == null || result.files.single.path == null) {
        // User canceled the picker or path is somehow null
        throw FilePickingFailure("");
      }

      final platformFile = result.files.single;

      final filePath = platformFile.path!;

      // 3. Basic Validation (Extension - belt and suspenders)
      if (platformFile.extension?.toLowerCase() != 'pdf') {
        throw PdfValidationFailure('Selected file is not a PDF (invalid extension).');
      }

      return filePath;

  }
}