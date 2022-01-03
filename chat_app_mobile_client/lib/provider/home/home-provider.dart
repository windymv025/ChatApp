import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  static final List<String> titles = [
    S.current.home,
    S.current.contact,
    S.current.request,
    S.current.setting,
  ];
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}
