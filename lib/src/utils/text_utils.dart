import 'package:intl/intl.dart';
import 'package:intl/intl.dart' show DateFormat;

String currencyFormat(double amount, String local, String pattern) =>
    NumberFormat.currency(locale: local, customPattern: pattern).format(amount);

///format theo [amount]VND
///vd: 1000 => 1.000VND
String formatVND(double amount) => currencyFormat(amount, 'vi', '#,###VND');

///format to [amount]đ
///vd: 1000 => 1.000đ
String formatDONG(double amount) => currencyFormat(amount, 'vi', '#,###đ');

String percentFormat(double percent) => '$percent%';

String milliSecondToString(int milliseconds, {String format = 'HH:mm:ss'}) =>
    DateFormat(format)
        .format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
