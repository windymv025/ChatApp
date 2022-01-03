import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:chat_app_mobile_client/ui/home/contact-page/contact-page.dart';
import 'package:chat_app_mobile_client/ui/home/request-page/request-page.dart';
import 'package:chat_app_mobile_client/ui/home/setting-page/setting-page.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/app-bar-factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'home-page/home-page.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final Map<int, Widget> _children = {
    0: const HomePage(),
  };
  final AppBarFactory _appBarFactory = AppBarFactory();

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final ContactProvider contactProvider = context.watch<ContactProvider>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBarFactory
            .getAppBar(HomeProvider.titles[homeProvider.pageIndex]),
        body: _children[homeProvider.pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: homeProvider.pageIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.message_rounded),
              label: HomeProvider.titles[0],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.contact_phone),
              label: HomeProvider.titles[1],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.group_add),
              label: HomeProvider.titles[2],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: HomeProvider.titles[3],
            ),
          ],
          onTap: (index) {
            if (index == 1) {
              contactProvider.loadContact();
            }
            loadPage(index);
            homeProvider.pageIndex = index;
          },
        ),
        floatingActionButton: homeProvider.pageIndex < 2
            ? FloatingActionButton(
                backgroundColor: kMainBlueColor,
                onPressed: () {
                  //TODO: add new group
                },
                child: const Icon(Icons.groups_sharp,
                    size: 30, color: Colors.white),
              )
            : null,
      ),
    );
  }

  void loadPage(int index) {
    setState(() {
      if (_children[index] == null) {
        switch (index) {
          case 1:
            _children[1] = const ContactPage();
            break;
          case 2:
            _children[2] = const RequestPage();
            break;
          case 3:
            _children[3] = const SettingPage();
            break;
          default:
            break;
        }
      }
    });
  }

  Widget getPage(int index) {
    loadPage(index);
    return _children[index]!;
  }
}
