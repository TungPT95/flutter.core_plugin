import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../base_state.dart';

extension ObjectUtils on Object {
  bool get isNull => this == null;

  bool get isNotNull => !isNull;
}

extension StringExtension on String {
  bool get isNullOrEmpty => this.isNull || this.isEmpty;

  bool get isNotNullAndEmpty => !this.isNullOrEmpty;

  String plus(String s) => this + s;

  String removeVnAccent() {
    final aRegex = '[áàả,ã,ạ,â,ấ,ầ,ẩ,ẫ,ậ,ă,ắ,ằ,ẳ,ẵ,ặ]';
    final dRegex = '[đ]';
    final eRegex = '[é,è,ẻ,ẽ,ẹ,ê,ế,ề,ể,ễ,ệ]';
    final iRegex = '[í,ì,ỉ,ĩ,ị]';
    final oRegex = '[ó,ò,ỏ,õ,ọ,ô,ố,ồ,ổ,ỗ,ộ,ơ,ớ,ờ,ở,ỡ,ợ]';
    final uRegex = '[ú,ù,ủ,ũ,ụ,ư,ứ,ừ,ử,ữ,ự]';
    final yRegex = '[ý,ỳ,ỷ,ỹ,ỵ]';

    String result = this.isNull
        ? null
        : this
            .replaceAll(RegExp(aRegex), 'a')
            .replaceAll(RegExp(aRegex.toUpperCase()), 'A')
            .replaceAll(RegExp(dRegex), 'd')
            .replaceAll(RegExp(dRegex.toUpperCase()), 'D')
            .replaceAll(RegExp(eRegex), 'e')
            .replaceAll(RegExp(eRegex.toUpperCase()), 'E')
            .replaceAll(RegExp(iRegex), 'i')
            .replaceAll(RegExp(iRegex.toUpperCase()), 'I')
            .replaceAll(RegExp(oRegex), 'o')
            .replaceAll(RegExp(oRegex.toUpperCase()), 'O')
            .replaceAll(RegExp(uRegex), 'u')
            .replaceAll(RegExp(uRegex.toUpperCase()), 'U')
            .replaceAll(RegExp(yRegex), 'y')
            .replaceAll(RegExp(yRegex.toUpperCase()), 'Y');

    return result;
  }

  ///chuỗi string này có tồn tại [keyword] hay ko
  bool contains(String keyword) {
    return this
        .removeVnAccent()
        .trim()
        .toLowerCase()
        .contains(keyword.removeVnAccent().trim().toLowerCase());
  }
}

extension ListExtension on List {
  bool get isNullOrEmpty => this.isNull || this.isEmpty;

  bool get isNotNullAndEmpty => !this.isNullOrEmpty;
}

extension MultipartFileExtension on MultipartFile {
  static MultipartFile fromFile(File file) =>
      MultipartFile.fromFileSync(file.path,
          filename: file.path.split(Platform.pathSeparator).last);
}

extension IntExtension on int {
  DateTime get toDateTimeFromServer =>
      DateTime.fromMillisecondsSinceEpoch((this ?? 0) * 1000);

  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this ?? 0);
}

extension BuildContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  double scaleWidth(double width) {
    return width * screenSize.width / designWidth;
  }

  double scaleHeight(double height) {
    return height * screenSize.height / designHeight;
  }

  double get screenWidthRatio => screenSize.width / designWidth;

  double get screenHeightRatio => screenSize.height / designHeight;

  double screenWidthFraction(double percent) {
    return screenSize.width * percent / 100;
  }

  double screenHeightFraction(double percent) {
    return screenSize.height * percent / 100;
  }
}

extension NumExtension on num {
  bool get isOdd => this % 2 != 0;

  bool get isEven => this % 2 == 0;
}