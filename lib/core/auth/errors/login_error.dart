




import 'package:aisign_project/shared/errors/base/failure_base.dart';

class LoginError implements Failure {


  final String message;
  final int? code;

  LoginError({
    required this.message,
    this.code,
  });

  @override
  String toString() {
    return 'LoginError: $message (code: $code)';
  }

  @override
  List<Object> get props => [message];

  @override
  bool? get stringify => true;

}