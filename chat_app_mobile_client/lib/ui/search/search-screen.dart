import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/ui/search/adpter/search-adapter.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/app-bar-factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final ContactProvider provider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBarFactory().getAppBar(SearchScreen.routeName),
      body: SearchAdpter(
        users: provider.searchContacts,
      ),
    );
  }
}
