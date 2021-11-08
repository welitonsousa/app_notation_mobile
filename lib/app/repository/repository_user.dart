import 'package:app_notation_mobile/app/models/model_user.dart';
import 'package:app_notation_mobile/const/dio.dart';
import 'package:dio/dio.dart';

class RepositoryUser {
  Future<ModelUser> login({required String email, required String pass}) async {
    final response = await dio.post("/sign", data: {
      "email": email,
      "password": pass,
    });

    final user = ModelUser.fromjson(response.data);
    return user;
  }

  Future<ModelUser> getme() async{
    final response = await dio.get("/user/me");
    return ModelUser.fromjson(response.data);
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

  Future<void> changePassword({
    required String pass,
    required String newPass,
    required bool logOutAll,
  }) async {
    await dio.put("/user/pass", data: {
      "pass": pass,
      "new_pass": newPass,
      "logout": logOutAll,
    });
  }

  Future<String> sendFile(String path, {String? message}) async {
    String fileName = path.split('/').last;
    
    FormData data = FormData.fromMap({
      'files': await MultipartFile.fromFile(path, filename: fileName),
    });
    
    final response = await dio.put('/user/picture', data: data);
    return response.data['picture'];
  }

}
