import 'package:chat_app_mobile_client/models/user.dart';

class Contact {
  Contact({
    required this.id,
    required this.userRequested,
    required this.userRequestedTo,
    required this.isAccepted,
    this.removedAt,
    required this.isPriority,
  });

  String id;
  User userRequested;
  User userRequestedTo;
  bool isAccepted;
  DateTime? removedAt;
  bool isPriority;

  factory Contact.fromMap(Map<String, dynamic> json) => Contact(
        id: json["_id"],
        userRequested: User.fromMap(json["user_requested"]),
        userRequestedTo: User.fromMap(json["user_requested_to"]),
        isAccepted: json["is_accepted"],
        removedAt: json["removed_at"] != null
            ? DateTime.parse(json["removed_at"])
            : null,
        isPriority: json["is_priority"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "user_requested": userRequested.toMap(),
        "user_requested_to": userRequestedTo.toMap(),
        "is_accepted": isAccepted,
        "removed_at": removedAt,
        "is_priority": isPriority,
      };
}
