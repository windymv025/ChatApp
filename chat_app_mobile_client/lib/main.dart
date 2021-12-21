import 'package:chat_app_mobile_client/provider/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'generated/l10n.dart';
import 'provider/language/language_profile.dart';
import 'provider/profile/profile_provider.dart';
import 'ui/signin/signin_screen.dart';
import 'utils/routes/routes.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ChangeNotifierProvider<LanguageProfile>(create: (_) => LanguageProfile()),
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
  ProfileProvider profile = ProfileProvider();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeModel = Provider.of<ThemeProvider>(context);
    LanguageProfile languageProfile = Provider.of<LanguageProfile>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => profile),
      ],
      child: MaterialApp(
        title: 'Chat App',
        theme: themeModel.themeMode,
        darkTheme: themeDataDark,
        themeMode: ThemeMode.system,
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
}
