import 'dart:io';

import 'package:dio/dio.dart';

extension ObjectUtils on Object {
  bool get isNull => this == null;

  bool get isNotNull => !isNull;
}

extension StringExtension on String {
  bool get isNullOrEmpty => this.isNull || this.isEmpty;

  String plus(String s) => this + s;
}

extension ListExtension on List {
  bool get isNullOrEmpty => this.isNull || this.isEmpty;
}

extension MultipartFileExtension on MultipartFile {
  static MultipartFile fromFile(File file) =>
      MultipartFile.fromFileSync(file.path,
          filename: file.path.split(Platform.pathSeparator).last);
}
