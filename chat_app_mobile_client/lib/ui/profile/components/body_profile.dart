import 'dart:io';

import 'package:chat_app_mobile_client/constants/assets.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

import 'infor_and_change_image.dart';
import 'profile_form.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  _BodyProfileState createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  File? _image;
  late AuthProvider profile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profile = context.watch<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      InforAndChangeImage(
        onTap: pickImage,
        image: _buildProfileImage(profile),
      ),
      Padding(
        child: ProfileForm(
          onSubmit: () {
            return profile.updateProfile();
          },
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    ]);
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
        profile.imageFile = _image;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image: ${e.message}');
    }
  }

  DecorationImage _buildProfileImage(AuthProvider profile) {
    if (_image != null) {
      return DecorationImage(
        fit: BoxFit.cover,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.dstATop,
        ),
        image: FileImage(_image!),
      );
    }
    if (profile.imageFile != null) {
      return DecorationImage(
        fit: BoxFit.cover,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.dstATop,
        ),
        image: FileImage(profile.imageFile!),
      );
    }
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: const ColorFilter.mode(
        Colors.white,
        BlendMode.dstATop,
      ),
      image: getImage(profile.profile),
    );
  }

  ImageProvider getImage(User? profile) {
    if (profile == null) return const AssetImage(Assets.assetsImagesUserIcon);
    if (profile.imageUrl.isNotEmpty) {
      return NetworkImage(profile.imageUrl);
    } else {
      return const AssetImage(Assets.assetsImagesUserIcon);
    }
  }
}
