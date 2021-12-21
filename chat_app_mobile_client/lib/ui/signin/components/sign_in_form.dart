import 'package:chat_app_mobile_client/constants/strings.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/provider/profile/profile_provider.dart';
import 'package:chat_app_mobile_client/ui/widgets/custom_suffix_icon.dart';
import 'package:chat_app_mobile_client/ui/widgets/default_button.dart';
import 'package:chat_app_mobile_client/ui/widgets/form_error.dart';
import 'package:chat_app_mobile_client/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  List<String> errors = [];

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
    final ProfileProvider profile = context.read<ProfileProvider>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(
            height: 20,
          ),
          buildPasswordFormField(),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, "ForgotPasswordScreen.routeName"),
                  child: Text(
                    S.current.forgot_password,
                    style: const TextStyle(
                        color: Color(0xff248EEF),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          FormError(errors: errors),
          const SizedBox(
            height: 10,
          ),
          DefaultButton(
            text: S.current.sign_in,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                DeviceUtils.hideKeyboard(context);
                // Navigator.pushNamedAndRemoveUntil(
                //     context, HomeScreen.routeName, (route) => false);
                // profile.copyProfile(kProfile);
              }
            },
          ),
        ],
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
        return;
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
}
