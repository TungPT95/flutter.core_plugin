import 'package:core_plugin/core_plugin.dart';
import 'package:intl/intl.dart';

class CurrencyUtils {
  static String currencyFormat(double amount, String local, String pattern) =>
      NumberFormat.currency(
              locale: local, customPattern: pattern, decimalDigits: 0)
          .format(amount);

  ///format theo [amount]VND
  ///vd: 1000 => 1.000VND
  static String formatVND(double amount) =>
      currencyFormat(amount, 'vi', '#,###VND');

  ///format to [amount]đ
  ///vd: 1000 => 1.000đ
  static String formatDONG(double amount) =>
      currencyFormat(amount, 'vi', '#,###đ');

  static String formatVNDWithCustomUnit(dynamic amount, {String unit = ''}) =>
      currencyFormat(amount, 'vi', '#,###${unit.isNullOrEmpty ? '' : unit}');
}
