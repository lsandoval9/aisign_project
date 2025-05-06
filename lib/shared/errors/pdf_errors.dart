

import 'package:aisign_project/shared/errors/base/failure_base.dart';

class FilePickingFailure extends Failure {
  const FilePickingFailure(super.message);
}


class PdfValidationFailure extends Failure {

  const PdfValidationFailure(super.message);
}