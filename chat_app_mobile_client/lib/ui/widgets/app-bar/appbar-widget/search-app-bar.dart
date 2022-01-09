import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ContactProvider contactProvider = Provider.of<ContactProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          contactProvider.clearSearch();
          Navigator.pop(context);
        },
      ),
      title: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                isSearching = value.isNotEmpty;
              });
              contactProvider.searchContact(value, authProvider.profile);
            },
            decoration: InputDecoration(
              hintText: S.of(context).search,
              border: InputBorder.none,
              suffixIcon: IconButton(
                  onPressed: () {
                    if (isSearching) {
                      setState(() {
                        _controller.clear();
                        isSearching = false;
                        contactProvider.clearSearch();
                      });
                    }
                  },
                  icon: Icon(isSearching ? Icons.close : Icons.search)),
            ),
          ),
        ),
      ),
    );
  }
}
