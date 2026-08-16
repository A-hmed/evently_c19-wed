import 'package:cloud_firestore/cloud_firestore.dart';

class EventDM {
  static const collectionName = "events";
  String id;
  String ownerId;
  int categoryId;
  String title;
  String description;
  DateTime date;

  EventDM({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.date,
  });

  EventDM.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        ownerId: json['ownerId'],
        title: json['title'],
        description: json['description'],
    categoryId: json['categoryId'],
        date: (json['date'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerId": ownerId,
    "title": title,
    "description": description,
    "categoryId": categoryId,
    "date": date,
  };
}
