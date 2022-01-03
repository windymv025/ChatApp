import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:chat_app_mobile_client/provider/theme/theme_provider.dart';
import 'package:chat_app_mobile_client/ui/home/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'generated/l10n.dart';
import 'provider/authentication/auth-provider.dart';
import 'provider/language/language_profile.dart';
import 'ui/signin/signin_screen.dart';
import 'utils/routes/routes.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ChangeNotifierProvider<LanguageProfile>(create: (_) => LanguageProfile()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HomeProvider homeProvider = HomeProvider();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeModel = Provider.of<ThemeProvider>(context);
    LanguageProfile languageProfile = Provider.of<LanguageProfile>(context);
    AuthProvider authProfile = Provider.of<AuthProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => authProfile),
        ChangeNotifierProvider(create: (context) => homeProvider),
      ],
      child: MaterialApp(
        title: 'Chat App',
        theme: themeModel.themeMode,
        darkTheme: themeDataDark,
        themeMode: ThemeMode.light,
        home: const SignInScreen(),
        routes: routes,
        locale: languageProfile.locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }

  Widget buidHomeScreen(bool isLogin) {
    if (isLogin) {
      return const HomeScreen();
    } else {
      return const SignInScreen();
    }
  }
}
