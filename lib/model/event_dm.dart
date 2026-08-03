class EventDM {
  static const collectionName = "events";
  String id;
  String ownerId;
  String category;
  String title;
  String description;
  DateTime date;

  EventDM({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
  });

  EventDM.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        ownerId: json['ownerId'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerId": ownerId,
    "title": title,
    "description": description,
    "category": category,
    "date": date,
  };
}
