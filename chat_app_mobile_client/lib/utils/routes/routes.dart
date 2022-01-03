import 'package:chat_app_mobile_client/ui/change-password/change-password-screen.dart';
import 'package:chat_app_mobile_client/ui/home/home-screen.dart';
import 'package:chat_app_mobile_client/ui/message/message-screen.dart';
import 'package:chat_app_mobile_client/ui/profile/profile-screen.dart';
import 'package:chat_app_mobile_client/ui/search/search-screen.dart';
import 'package:chat_app_mobile_client/ui/signin/signin_screen.dart';
import 'package:chat_app_mobile_client/ui/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  MessageScreen.routeName: (context) => const MessageScreen(),
  ChangePasswordScreen.routeName: (context) => const ChangePasswordScreen(),
  SearchScreen.routeName: (context) => const SearchScreen(),
};
