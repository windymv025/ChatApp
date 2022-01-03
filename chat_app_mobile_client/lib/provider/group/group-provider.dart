import 'package:chat_app_mobile_client/data/network/apis/group/group-api.dart';
import 'package:chat_app_mobile_client/models/group.dart';
import 'package:flutter/cupertino.dart';

class GroupProvider extends ChangeNotifier {
  final List<Group> _groups = [];
  final GroupApi _groupApi = GroupApi();

  List<Group> get groups {
    loadGroup();
    return _groups;
  }

  void loadGroup() {
    _groupApi.getGroups().then((groups) {
      _groups.clear();
      for (var g in groups) {
        _groups.add(Group.fromMap(g));
      }
      notifyListeners();
    });
  }
}
