import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/constants/strings.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/ui/home/home-screen.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/custom_suffix_icon.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/default_button.dart';
import 'package:chat_app_mobile_client/ui/widgets/components/form_error.dart';
import 'package:chat_app_mobile_client/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

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
  bool isLoading = false;

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
    AuthProvider authProvider = context.read<AuthProvider>();
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
          isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kMainBlueColor),
                  backgroundColor: Colors.grey,
                )
              : DefaultButton(
                  text: S.current.sign_up,
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      DeviceUtils.hideKeyboard(context);
                      setState(() {
                        isLoading = true;
                        authProvider
                            .register(email!, password!, fullName!)
                            .then((value) {
                          if (value) {
                            Navigator.of(context).pushReplacementNamed(
                              HomeScreen.routeName,
                            );
                          } else {
                            isLoading = false;
                            addError(authProvider.message);
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

  TextFormField buildFullNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => fullName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(S.current.please_enter_your_name);
        } else {
          addError(S.current.please_enter_your_name);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(S.current.please_enter_your_name);
          return "";
        } else {
          removeError(S.current.please_enter_your_name);
          return null;
        }
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
        password = value;
        checkPassword(value);
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        conformPassword = value;
        checkConformPassword(value);
      },
      validator: (value) {
        return value != null ? checkConformPassword(value) : null;
      },
      decoration: InputDecoration(
        labelText: S.current.confirm_password,
        hintText: S.current.re_enter_your_password,
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

  String? checkConformPassword(String value) {
    bool isError = false;
    if (value.isNotEmpty) {
      removeError(S.current.please_enter_conform_password);
      isError = false;
    } else {
      addError(S.current.please_enter_conform_password);
      isError = true;
    }
    if (conformPassword == password || value.isEmpty) {
      removeError(S.current.password_dont_match);
      isError = false;
    }
    if (conformPassword != password) {
      addError(S.current.password_dont_match);
      isError = true;
    }
    return isError ? "" : null;
  }
}
