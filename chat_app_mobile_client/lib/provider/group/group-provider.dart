import 'package:chat_app_mobile_client/data/network/apis/group/group-api.dart';
import 'package:chat_app_mobile_client/models/group.dart';
import 'package:chat_app_mobile_client/service/socket-service.dart';
import 'package:flutter/cupertino.dart';

class GroupProvider extends ChangeNotifier {
  final List<Group> _groups = [];
  final GroupApi _groupApi = GroupApi();
  SocketService? _socketService;

  List<Group> get groups {
    loadGroup();
    return _groups;
  }

  init() {
    loadGroup();
    _socketService = SocketService.instance;
    _socketService?.onIsAddedToGroup(handleIsAddedToGroup);
  }

  handleIsAddedToGroup(data) {
    if (data != null) {
      var group = Group.fromMap(data);
      if (_groups.where((element) => group.id == element.id).isEmpty) {
        _groups.add(group);
      }
      notifyListeners();
    }
  }

  loadGroup() async {
    var groups = await _groupApi.getGroups();
    _groups.clear();
    for (var g in groups) {
      _groups.add(Group.fromMap(g));
    }
    notifyListeners();
  }

  void createGroup(String name) {
    _groupApi.createGroup(name).then((group) {
      _groups.add(Group.fromMap(group));
      notifyListeners();
    });
  }

  joinGroup(String groupId) async {
    await _socketService?.joinGroupEmit(groupId);
  }

  leaveGroup(String groupId) async {
    await _socketService?.leaveGroupEmit(groupId);
  }

  void clean() {
    _groups.clear();
    notifyListeners();
  }
}
