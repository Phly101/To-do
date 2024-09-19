import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  int dateOnly() {
    var newDateTime = DateTime(year, month, day);
    return newDateTime.millisecondsSinceEpoch;
  }
  String formatDate(){
    final DateFormat formatter = DateFormat('yyyy/MMM/ EEE dd');
    return formatter.format((this));
  }

}

extension TimeUtils on TimeOfDay {
  int timeSinceEpoch() {
    var newTime = DateTime(0, 0, 0, hour, minute);
    return newTime.millisecondsSinceEpoch;
  }
  String formatTime(){
    final DateFormat formatter = DateFormat('HH:mm a');

    return formatter.format(DateTime(0,0,0,hour,minute));

  }


}
extension TimeFormats on  int{

  String formatTime(){
    final DateFormat formatter = DateFormat('HH:mm a');

    return formatter.format(DateTime.fromMillisecondsSinceEpoch(this));

  }
  String formatDate(){
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(this));
  }

}
