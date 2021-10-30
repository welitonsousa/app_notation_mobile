import 'package:app_notation_mobile/app/controllers/controller_profile.dart';
import 'package:app_notation_mobile/env.dart';
import 'package:dio/dio.dart';

final options = BaseOptions(
    baseUrl: Env.BASE_URL,
    connectTimeout: 30000,
    validateStatus: (status) {
      if (status == 401) ControllerProfile.instance.logOut();
      return (status ?? 422) <= 300;
    });

final dio = Dio(options);
