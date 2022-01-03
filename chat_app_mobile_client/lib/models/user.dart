import 'dart:convert';

class User {
  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.imageUrl,
      required this.createdAt,
      this.isPriority = false});

  String id;
  String email;
  String name;
  String imageUrl;
  DateTime createdAt;
  bool isPriority;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        isPriority: json["is_priority"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "email": email,
        "name": name,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "is_priority": isPriority,
      };
}
