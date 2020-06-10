import 'extensions.dart';

String percentFormat(double percent) => '$percent%';

class TextUtil {
  ///chuỗi [source] có bao gồm [keyword] hay ko
  static bool contains(String source, String keyword) {
    return source
        .removeVnAccent()
        .trim()
        .toLowerCase()
        .contains(keyword.removeVnAccent().trim().toLowerCase());
  }
}

void main() {
  final abc = 'àá ẮảđẵỉêỹôữỨ'.removeVnAccent();
  print('[TUNG] ===> $abc');
}
