import 'package:chat_app_mobile_client/constants/assets.dart';
import 'package:chat_app_mobile_client/constants/enums.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:chat_app_mobile_client/provider/message/message-provider.dart';
import 'package:chat_app_mobile_client/ui/profile/profile-screen.dart';
import 'package:chat_app_mobile_client/ui/search/search-screen.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/circle_avatar_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    final MessageProvider messageProvider = context.read<MessageProvider>();
    final ContactProvider contactProvider = context.read<ContactProvider>();
    final HomeProvider homeProvider = context.read<HomeProvider>();
    return DefaultTabController(
      length: 2,
      initialIndex: homeProvider.tabHomeIndex,
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
            homeProvider.tabHomeIndex = value;
            messageProvider.setContacts(contactProvider.contacts);
            messageProvider.currentPage = value;
            if (value == 0) {
              messageProvider.getPriorityMessages();
            } else {
              messageProvider.getNormalMessages();
            }
          },
          tabs: [
            Tab(
              text: S.current.tab_priority,
            ),
            Tab(
              text: S.current.tab_normal,
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider? getImage(User profile) {
    if (profile.imageUrl.isNotEmpty) {
      return NetworkImage(profile.imageUrl);
    } else {
      return const AssetImage(Assets.assetsImagesUserIcon);
    }
  }
}
