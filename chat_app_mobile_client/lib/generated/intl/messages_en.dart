// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "dont_have_account":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "enter_email": MessageLookupByLibrary.simpleMessage("Enter your email"),
        "enter_email_to_reset": MessageLookupByLibrary.simpleMessage(
            "Enter your email address to we\'ll send you a OTP code to reset your password"),
        "enter_password":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "or_continue_with":
            MessageLookupByLibrary.simpleMessage("Or continue with"),
        "otp_is_invalid": MessageLookupByLibrary.simpleMessage(
            "OTP is Invalid, please try again"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "password_dont_match":
            MessageLookupByLibrary.simpleMessage("Password don\'t match"),
        "please_enter_email":
            MessageLookupByLibrary.simpleMessage("Please enter your email"),
        "please_enter_email_valid":
            MessageLookupByLibrary.simpleMessage("Please enter valid email"),
        "please_enter_otp": MessageLookupByLibrary.simpleMessage(
            "Please Enter OTP in your email"),
        "please_enter_password":
            MessageLookupByLibrary.simpleMessage("Please enter your password"),
        "please_enter_password_min": MessageLookupByLibrary.simpleMessage(
            "Please enter password minimum 8 characters"),
        "please_enter_your_name":
            MessageLookupByLibrary.simpleMessage("Please enter your name"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Sign In"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign Up")
      };
}
