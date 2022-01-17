import 'package:chat_app_mobile_client/constants/colors.dart';
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
  Size get preferredSize => const Size.fromHeight(64);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ContactProvider contactProvider = Provider.of<ContactProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 25),
      color: Theme.of(context).appBarTheme.backgroundColor,
      width: widget.preferredSize.width,
      height: widget.preferredSize.height + 20,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              contactProvider.clearSearch();
              Navigator.pop(context);
            },
          ),
          Expanded(
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
                style: const TextStyle(
                  color: Colors.black,
                ),
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
          const SizedBox(width: 15,),
        ],
      ),
    );
  }
}
