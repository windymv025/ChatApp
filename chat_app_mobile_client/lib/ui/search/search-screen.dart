import 'package:chat_app_mobile_client/constants/enums.dart';
import 'package:chat_app_mobile_client/ui/search/factory/body-search-factory.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/app-bar-factory.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    TypebodySearch typeBody =
        ModalRoute.of(context)!.settings.arguments! as TypebodySearch;
    return Scaffold(
      appBar: AppBarFactory().getAppBar(SearchScreen.routeName),
      body: BodySearchFactory.getBodySearch(typeBody),
    );
  }
}
