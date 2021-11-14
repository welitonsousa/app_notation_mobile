class ModelNotes {
  String id;
  String title;
  String body;
  String userId;
  String date;
  String dateUpdate;

  ModelNotes({
    this.dateUpdate = "",
    required this.id,
    required this.body,
    required this.date,
    required this.title,
    required this.userId,
  });

  factory ModelNotes.fromJson(Map json) {
    return ModelNotes(
      dateUpdate: json["updated_at"] ?? "",
      body: json["body"],
      date: json["created_at"],
      id: json["id"],
      title: json["title"],
      userId: json["user_id"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "id": this.id,
      "title": this.title,
      "body": this.body,
    };
    return data;
  }
}
