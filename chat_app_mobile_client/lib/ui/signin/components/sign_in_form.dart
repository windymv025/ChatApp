import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/constants/strings.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/ui/home/home-screen.dart';
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
  bool isLoginPressed = false;

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
    final AuthProvider profile = context.read<AuthProvider>();
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
            height: 15,
          ),
          FormError(errors: errors),
          const SizedBox(
            height: 10,
          ),
          isLoginPressed
              ? CircularProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation(kMainBlueColor),
                  backgroundColor: Colors.grey[200],
                )
              : DefaultButton(
                  text: S.current.sign_in,
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      DeviceUtils.hideKeyboard(context);
                      setState(() {
                        isLoginPressed = true;
                        profile.login(email!, password!).then((value) {
                          if (value) {
                            Navigator.of(context).pushReplacementNamed(
                              HomeScreen.routeName,
                            );
                          } else {
                            addError(S.current.invalid_credentials);
                            isLoginPressed = false;
                          }
                        });
                      });
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
        checkEmail(value);
      },
      validator: (value) {
        return value != null ? checkEmail(value) : null;
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
        checkPassword(value);
        return;
      },
      validator: (value) {
        return value != null ? checkPassword(value) : null;
      },
      decoration: InputDecoration(
        label: Text(S.current.password),
        hintText: S.current.enter_password,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(icon: Icons.lock_outline_rounded),
      ),
    );
  }

  String? checkEmail(String value) {
    bool isError = false;
    if (value.isNotEmpty) {
      removeError(S.current.please_enter_email);
      isError = false;
    } else {
      addError(S.current.please_enter_email);
      isError = true;
    }
    if (emailValidatorRegExp.hasMatch(value) || value.isEmpty) {
      removeError(S.current.please_enter_email_valid);
      isError = false;
    } else {
      addError(S.current.please_enter_email_valid);
      isError = true;
    }
    return isError ? "" : null;
  }

  String? checkPassword(String value) {
    bool isError = false;
    if (value.isNotEmpty) {
      removeError(S.current.please_enter_password);
      isError = false;
    } else {
      addError(S.current.please_enter_password);
      isError = true;
    }
    if (value.length >= 6 || value.isEmpty) {
      removeError(S.current.please_enter_password_min);
      isError = false;
    } else {
      addError(S.current.please_enter_password_min);
      isError = true;
    }
    return isError ? "" : null;
  }
}
