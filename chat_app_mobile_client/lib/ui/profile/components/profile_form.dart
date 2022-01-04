import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/custom_suffix_icon.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key, required this.onSubmit}) : super(key: key);
  final Function onSubmit;

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, profile, _) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            // email
            TextFormField(
              initialValue: profile.profile.email,
              enabled: false,
              decoration: InputDecoration(
                label: Text(S.current.full_name),
                hintText: S.current.please_enter_your_name,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: const CustomSurffixIcon(icon: Icons.email_outlined),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // fullname
            TextFormField(
              initialValue: profile.profile.name,
              keyboardType: TextInputType.name,
              onSaved: (newValue) => profile.profile.name = newValue!,
              onChanged: (value) {
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return S.current.please_enter_your_name;
                }
                if (value.length < 3) {
                  return S.current.err_name_short;
                }
                if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                  return S.current.err_name_invalid;
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text(S.current.full_name),
                hintText: S.current.please_enter_your_name,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon:
                    const CustomSurffixIcon(icon: Icons.person_outline_rounded),
              ),
            ),

            //save
            const SizedBox(
              height: 20,
            ),
            DefaultButton(
              text: S.current.save_changes,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSubmit();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.current.Profile_updated),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.current.err_fill_all),
                  ));
                }
              },
            ),

            //
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    });
  }
}
