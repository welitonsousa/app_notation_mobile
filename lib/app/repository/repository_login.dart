import 'package:app_notation_mobile/app/models/model_user.dart';
import 'package:app_notation_mobile/const/dio.dart';

class RepositoryUser {
  Future<ModelUser> login({required String email, required String pass}) async {
    final response = await dio.post("/sign", data: {
      "email": email,
      "password": pass,
    });

    final user = ModelUser.fromjson(response.data);
    return user;
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
