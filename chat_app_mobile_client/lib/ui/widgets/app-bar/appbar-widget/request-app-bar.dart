import 'package:chat_app_mobile_client/constants/assets.dart';
import 'package:chat_app_mobile_client/constants/enums.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/ui/profile/profile-screen.dart';
import 'package:chat_app_mobile_client/ui/search/search-screen.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/circle_avatar_button.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class RequestAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RequestAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  _RequestAppBarState createState() => _RequestAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _RequestAppBarState extends State<RequestAppBar> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    return AppBar(
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
    );
  }
}
