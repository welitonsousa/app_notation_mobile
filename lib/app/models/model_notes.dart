class ModelNotes {
  String id;
  String title;
  String body;
  String userId;
  String date;

  ModelNotes({
    required this.id,
    required this.body,
    required this.date,
    required this.title,
    required this.userId,
  });
  
  factory ModelNotes.fromJson(Map json) {
    return ModelNotes(
      body: json["body"],
      date: json["created_at"],
      id: json["id"],
      title: json["title"],
      userId: json["user_id"],
    );
  }

}
