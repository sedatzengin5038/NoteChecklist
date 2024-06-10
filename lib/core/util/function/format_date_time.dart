import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FormatDateTime {
  FormatDateTime._();
  
  static const String _fixFormat = 'Edited 12:00';
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dayAndMonthFormat = DateFormat('dd MMM');
  static final DateFormat _fullFormat = DateFormat('dd MMM yy');

  static String getFormatDateTime(Timestamp timestamp) {
    final now = Timestamp.now();
    
    if (timestamp.toDate().year == now.toDate().year &&
        timestamp.toDate().month == now.toDate().month &&
        timestamp.toDate().day == now.toDate().day) {
      if (timestamp.toDate().hour == 12 && timestamp.toDate().minute == 0) {
        return _fixFormat;
      } else {
        return 'Edited ${_timeFormat.format(timestamp.toDate())}';
      }
    } else if (timestamp.toDate().year == now.toDate().year) {
      return 'Edited ${_dayAndMonthFormat.format(timestamp.toDate())}';
    } else {
      return 'Edited ${_fullFormat.format(timestamp.toDate())}';
    }
  }
}
