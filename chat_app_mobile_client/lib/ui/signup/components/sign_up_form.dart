import 'package:chat_app_mobile_client/constants/strings.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/ui/signin/signin_screen.dart';
import 'package:chat_app_mobile_client/ui/widgets/custom_suffix_icon.dart';
import 'package:chat_app_mobile_client/ui/widgets/default_button.dart';
import 'package:chat_app_mobile_client/ui/widgets/form_error.dart';
import 'package:chat_app_mobile_client/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  List<String> errors = [];

  String? fullName;
  String? conformPassword;

  void addError(String error) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError(String error) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          const SizedBox(
            height: 20,
          ),
          buildEmailFormField(),
          const SizedBox(
            height: 20,
          ),
          buildPasswordFormField(),
          const SizedBox(
            height: 20,
          ),
          buildConformPassFormField(),
          const SizedBox(height: 15),
          FormError(errors: errors),
          const SizedBox(
            height: 10,
          ),
          DefaultButton(
            text: S.current.sign_up,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                DeviceUtils.hideKeyboard(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.routeName, (route) => false);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => fullName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(S.current.please_enter_your_name);
        }
        fullName = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(S.current.please_enter_your_name);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(S.current.full_name),
        hintText: S.current.please_enter_your_name,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(icon: Icons.person_outline_rounded),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(S.current.please_enter_email);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(S.current.please_enter_email_valid);
        }
        email = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(S.current.please_enter_email);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(S.current.please_enter_email_valid);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Email"),
        hintText: S.current.enter_email,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(icon: Icons.mail_outline_rounded),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(S.current.please_enter_password);
        } else if (value.length >= 8) {
          removeError(S.current.please_enter_password_min);
        }
        password = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(S.current.please_enter_password);
          return "";
        } else if (value.length < 8) {
          addError(S.current.please_enter_password_min);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(S.current.password),
        hintText: S.current.enter_password,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(icon: Icons.lock_outline_rounded),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(S.current.please_enter_password);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(S.current.password_dont_match);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(S.current.please_enter_password);
          return "";
        } else if ((password != value)) {
          addError(S.current.password_dont_match);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: S.current.confirm_password,
        hintText: S.current.re_enter_your_password,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(icon: Icons.lock_outline_rounded),
      ),
    );
  }
}
