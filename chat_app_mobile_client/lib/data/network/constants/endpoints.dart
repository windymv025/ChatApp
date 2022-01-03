class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "server-chat-ts.herokuapp.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String login = "/login";
  static const String register = "/register";
  static const String auth = "/auth";
  static const String search = "/search";
  static const String contacts = "/contacts";
  static const String addContact = "/contacts/add";
  static const String acceptContact = "/contacts/accept";
  static const String removeContact = "/contacts/remove";
  static const String addPriority = "/priority/add";
  static const String removePriority = "/priority/remove";
  static const String blockUser = "/block/add";
  static const String getBlocks = "/block";
  static const String unBlockUser = "/block/remove";
  static const String getGroups = "/group";
  static const String getGroupMembers = "/group/members";
  static const String createGroup = "/group/create";
  static const String addGroupMember = "/group/add";
  static const String leaveGroup = "/group/leave";
  static const String getMainMessage = "/message";
  static const String getGroupMessage = "/message/group";
  static const String getInvidualMessage = "/message/invidual";
  static const String addInvidualMessage = "/message/invidual/add";
  static const String addGroupMessage = "/message/group/add";
}
