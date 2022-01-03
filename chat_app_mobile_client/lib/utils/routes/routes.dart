import 'package:chat_app_mobile_client/ui/home/home-screen.dart';
import 'package:chat_app_mobile_client/ui/signin/signin_screen.dart';
import 'package:chat_app_mobile_client/ui/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};
