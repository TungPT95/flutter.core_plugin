import 'package:intl/intl.dart';

String percentFormat(double percent) => '$percent%';

String milliSecondToString(int milliseconds, {String format = 'HH:mm:ss'}) =>
    DateFormat(format)
        .format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
