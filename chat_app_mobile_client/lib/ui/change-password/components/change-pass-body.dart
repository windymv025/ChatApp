import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/custom_suffix_icon.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/default_button.dart';
import 'package:chat_app_mobile_client/ui/widgets/components/form_error.dart';
import 'package:chat_app_mobile_client/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ChangePassBody extends StatefulWidget {
  const ChangePassBody({Key? key}) : super(key: key);

  @override
  _ChangePassBodyState createState() => _ChangePassBodyState();
}

class _ChangePassBodyState extends State<ChangePassBody> {
  final _formKey = GlobalKey<FormState>();
  String? password;
  List<String> errors = [];

  String? conformPassword;
  String? oldPassword;
  bool isLoading = false;

  String? _oudPass = "";

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
    _oudPass = authProvider.profile?.password;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildOldPasswordFormField(),
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
                    text: S.current.change_password,
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // if all are valid then go to success screen
                        DeviceUtils.hideKeyboard(context);
                        setState(() {
                          isLoading = true;
                        });
                        authProvider.changePassword(password!).then((value) {
                          setState(() {
                            if (value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text(S.current.change_password_success),
                              ));
                            } else {
                              addError(S.current.error_change_password);
                            }
                            isLoading = false;
                          });
                        });
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }

  TextFormField buildOldPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => oldPassword = newValue,
      onChanged: (value) {
        oldPassword = value;
      },
      validator: (value) {
        return value != null ? checkOldPassword(value) : null;
      },
      decoration: InputDecoration(
        hintText: S.current.enter_old_password,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: const CustomSurffixIcon(icon: Icons.lock_outline_rounded),
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
        hintText: S.current.new_pass,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
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
        hintText: S.current.confirm_password,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: const CustomSurffixIcon(icon: Icons.lock_outline_rounded),
      ),
    );
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

  String? checkPassword(String value) {
    bool isError = false;
    if (value.isNotEmpty) {
      removeError(S.current.enter_new_password);
      isError = false;
    } else {
      addError(S.current.enter_new_password);
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

  String? checkOldPassword(String value) {
    if (value == _oudPass) {
      removeError(S.current.old_pass_wrong);
      return null;
    } else {
      addError(S.current.old_pass_wrong);
      return "";
    }
  }
}
