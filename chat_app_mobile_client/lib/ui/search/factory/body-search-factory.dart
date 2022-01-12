import 'package:chat_app_mobile_client/constants/enums.dart';
import 'package:chat_app_mobile_client/ui/search/body/contact-search-body.dart';
import 'package:chat_app_mobile_client/ui/search/body/user-search-body.dart';
import 'package:flutter/cupertino.dart';

class BodySearchFactory {
  static final Map<TypebodySearch, Widget> _bodySearch = {
    TypebodySearch.contact: const ContactSearchBody(),
    TypebodySearch.user: const UserSearchBody(),
  };
  static getBodySearch(TypebodySearch type) {
    if (_bodySearch.containsKey(type)) {
      return _bodySearch[type];
    } else {
      return const ContactSearchBody();
    }
  }
}
