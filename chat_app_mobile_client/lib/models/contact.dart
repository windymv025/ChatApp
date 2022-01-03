import 'dart:convert';

class Contact {
  Contact({
    required this.id,
    required this.email,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
  });

  String id;
  String email;
  String name;
  String imageUrl;
  DateTime createdAt;

  factory Contact.fromJson(String str) => Contact.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Contact.fromMap(Map<String, dynamic> json) => Contact(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "email": email,
        "name": name,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
      };
}