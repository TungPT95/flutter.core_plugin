import 'package:intl/intl.dart';



class DataTimeUtils {
  static const String FORMAT_DEFAULT = 'HH:mm:ss';
  static const String FORMAT_1 = 'HH:mm:ss mm/dd/yyyy';
  static String milliSecondToDateString(int milliseconds,
          {String format = FORMAT_DEFAULT}) =>
      DateFormat(format)
          .format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
}
