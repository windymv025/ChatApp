import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  static final List<String> titles = [
    S.current.message,
    S.current.contact,
    S.current.request,
    S.current.setting,
  ];
  int _pageIndex = 0;
  int _tabHomeIndex = 0;
  int _tabContactIndex = 0;

  int get pageIndex => _pageIndex;
  set pageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  int get tabHomeIndex => _tabHomeIndex;
  set tabHomeIndex(int index) {
    _tabHomeIndex = index;
    notifyListeners();
  }

  int get tabContactIndex => _tabContactIndex;
  set tabContactIndex(int index) {
    _tabContactIndex = index;
    notifyListeners();
  }
}
