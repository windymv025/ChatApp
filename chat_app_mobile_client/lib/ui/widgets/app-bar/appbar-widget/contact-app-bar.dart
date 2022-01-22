import 'package:chat_app_mobile_client/constants/assets.dart';
import 'package:chat_app_mobile_client/constants/enums.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:chat_app_mobile_client/ui/profile/profile-screen.dart';
import 'package:chat_app_mobile_client/ui/search/search-screen.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/circle_avatar_button.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ContactAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ContactAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  _ContactAppBarState createState() => _ContactAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _ContactAppBarState extends State<ContactAppBar> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    final HomeProvider homeProvider = context.watch<HomeProvider>();
    return DefaultTabController(
      length: 2,
      initialIndex: homeProvider.tabContactIndex,
      child: AppBar(
        leading: Center(
          child: CircleAvatarButton(
            image: getImage(authProvider.profile),
            onPressed: () =>
                Navigator.pushNamed(context, ProfileScreen.routeName),
          ),
        ),
        title: Center(
          child: Text(
            widget.title,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SearchScreen.routeName,
                    arguments: TypebodySearch.contact);
              },
              icon: const Icon(
                Icons.search_rounded,
                size: 30,
              ))
        ],
        bottom: TabBar(
          labelColor: Colors.white,
          labelStyle: titleStyleWhite,
          indicatorColor: Colors.white,
          automaticIndicatorColorAdjustment: true,
          onTap: (value) {
            homeProvider.tabContactIndex = value;
          },
          tabs: [
            Tab(
              text: S.current.tab_friend,
            ),
            Tab(
              text: S.current.tab_group,
            ),
          ],
        ),
      ),
    );
  }
}
