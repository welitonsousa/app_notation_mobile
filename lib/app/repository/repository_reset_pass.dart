import 'package:app_notation_mobile/const/dio.dart';

class RepositoryResetPass {
  Future<void> sendEmailCode({required String email}) async {
    await dio.post('/send/code-pass', data: {'email': email});
  }

  Future<void> valideCode({required String email, required String code}) async {
    await dio.post('/valide/code', data: {'email': email, 'hash': code});
  }

  Future<void> resetPass({
    required String email,
    required String code,
    required String newPass,
  }) async {
    await dio.put('/reset/pass', data: {
      'email': email,
      'hash': code,
      'password': newPass,
    });
  }
}
