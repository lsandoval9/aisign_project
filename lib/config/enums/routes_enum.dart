import 'package:equatable/equatable.dart';

enum RoutesEnum implements Equatable {

  dashboard("/dashboard", "Dashboard"),
  login("/login", "Login"),
  pdfViewer("/pdf_viewer", "PDF Viewer");


  final String path;
  final String name;

  const RoutesEnum(this.path, this.name);

  @override
  List<Object?> get props => [path];

  @override
  bool? get stringify => true;

}