class ModelUser {
  String user;
  String picture;
  String token;

  ModelUser({
    required this.user,
    this.picture = "",
    required this.token,
  });

  factory ModelUser.fromjson(Map json) {
    return ModelUser(
      token: json["token"] ?? "",
      user: json["user"] ?? "",
      picture: json["picture"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      "user": this.user,
      "picture": this.picture,
      "token": this.token
    };
    return data;
  }
}
