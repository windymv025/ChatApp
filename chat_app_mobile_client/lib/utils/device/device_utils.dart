//
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Helper class for device related operations.
///
class DeviceUtils {
  ///
  /// hides the keyboard if its already open
  ///
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// orientation
  ///
  static double getScaledSize(BuildContext context, double scale) =>
      scale *
      (MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height);

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// width
  ///
  static double getScaledWidth(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.width;

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// height
  ///
  static double getScaledHeight(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.height;

  static String getStringTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime temp = DateTime(
        now.year - dateTime.year,
        now.month - dateTime.month,
        now.day - dateTime.day,
        now.hour - dateTime.hour,
        now.minute - dateTime.minute,
        now.second - dateTime.second);
    String result = "";
    if (dateTime.year == now.year) {
      if (dateTime.month == now.month) {
        if (dateTime.day == now.day) {
          if (dateTime.hour == now.hour) {
            result = "${DateFormat("mm").format(temp)} ago";
          } else {
            result = "${DateFormat("HH:mm").format(temp)} ago";
          }
        } else {
          if (now.day - dateTime.day < 7) {
            result = DateFormat("EEE, HH:mm").format(dateTime);
          } else {
            result = DateFormat("MMM dd").format(dateTime);
          }
        }
      } else {
        result = DateFormat("MMM dd").format(dateTime);
      }
    } else {
      result = DateFormat("MMM dd, yyyy").format(dateTime);
    }

    return result;
  }
}
