// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dark": MessageLookupByLibrary.simpleMessage("Tối"),
        "dont_have_account":
            MessageLookupByLibrary.simpleMessage("Chưa có tài khoản?"),
        "enter_email":
            MessageLookupByLibrary.simpleMessage("Nhập email của bạn"),
        "enter_email_to_reset": MessageLookupByLibrary.simpleMessage(
            "Hãy nhập địa chỉ Email của bạn, chúng tôi sẽ gửi mã OTP cho bạn để thiết lập lại mật khẩu"),
        "enter_password":
            MessageLookupByLibrary.simpleMessage("Nhập mật khẩu của bạn"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Quyên mật khẩu?"),
        "light": MessageLookupByLibrary.simpleMessage("Sáng"),
        "otp_is_invalid": MessageLookupByLibrary.simpleMessage(
            "OTP không hợp lệ, xin vui lòng thử lại"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "password_dont_match":
            MessageLookupByLibrary.simpleMessage("Mật khẩu không khớp"),
        "please_enter_email":
            MessageLookupByLibrary.simpleMessage("Hãy nhập email của bạn"),
        "please_enter_email_valid":
            MessageLookupByLibrary.simpleMessage("Hãy nhập email hợp lệ"),
        "please_enter_otp": MessageLookupByLibrary.simpleMessage(
            "Hãy nhập mã OTP đã được gởi trong email của bạn"),
        "please_enter_password":
            MessageLookupByLibrary.simpleMessage("Hãy nhập mật khẩu của bạn"),
        "please_enter_password_min":
            MessageLookupByLibrary.simpleMessage("Mật khẩu tối thiểu 8 ký tự"),
        "please_enter_your_name":
            MessageLookupByLibrary.simpleMessage("Hãy nhập tên của bạn"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Đăng ký")
      };
}
