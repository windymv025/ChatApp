import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/ui/home/contact-page/tabview/components/friend-item.dart';
import 'package:flutter/cupertino.dart';

class FriendFactory {
  Widget getFriendItem(Contact contact, User profile) {
    User friend = contact.userRequested;
    if (contact.userRequested.id == profile.id) {
      friend = contact.userRequestedTo;
    } else {
      friend = contact.userRequested;
    }

    return FriendItem(friend: friend);
  }
}
