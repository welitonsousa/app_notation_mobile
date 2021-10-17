import 'package:app_notation_mobile/const/dio.dart';

class RepositoryUser {
  Future<void> login({required String email, required String pass}) async {
    await dio.post("/sign", data: {
      "email": email,
      "password": pass,
    });
  }

  Future<void> registration({
    required String email,
    required String pass,
    required String name,
  }) async {
    await dio.post("/users", data: {
      "name": name,
      "email": email,
      "password": pass,
    });
  }
}
