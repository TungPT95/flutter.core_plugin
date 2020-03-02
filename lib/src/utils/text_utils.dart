import 'extensions.dart';

String percentFormat(double percent) => '$percent%';

class TextUtil {
  static String removeVnAccent(String input) {
    final aRegex = '[á,à,ả,ã,ạ,â,ấ,ầ,ẩ,ẫ,ậ,ă,ắ,ằ,ẳ,ẵ,ặ]';
    final dRegex = '[đ]';
    final eRegex = '[é,è,ẻ,ẽ,ẹ,ê,ế,ề,ể,ễ,ệ]';
    final iRegex = '[í,ì,ỉ,ĩ,ị]';
    final oRegex = '[ó,ò,ỏ,õ,ọ,ô,ố,ồ,ổ,ỗ,ộ,ơ,ớ,ờ,ở,ỡ,ợ]';
    final uRegex = '[ú,ù,ủ,ũ,ụ,ư,ứ,ừ,ử,ữ,ự]';
    final yRegex = '[ý,ỳ,ỷ,ỹ,ỵ]';

    return input.isNull
        ? ''
        : input
            .replaceAll(
                RegExp(aRegex.plus('|').plus(aRegex.toUpperCase())), 'a')
            .replaceAll(
                RegExp(dRegex.plus('|').plus(dRegex.toUpperCase())), 'd')
            .replaceAll(
                RegExp(eRegex.plus('|').plus(eRegex.toUpperCase())), 'e')
            .replaceAll(
                RegExp(iRegex.plus('|').plus(iRegex.toUpperCase())), 'i')
            .replaceAll(
                RegExp(oRegex.plus('|').plus(oRegex.toUpperCase())), 'o')
            .replaceAll(
                RegExp(uRegex.plus('|').plus(uRegex.toUpperCase())), 'u')
            .replaceAll(
                RegExp(yRegex.plus('|').plus(yRegex.toUpperCase())), 'y');
  }
}

void main() {
  final abc = TextUtil.removeVnAccent('đẵỉêỹôữỨ');
  print('[TUNG] ===> $abc');
}
