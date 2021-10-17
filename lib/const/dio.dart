import 'package:app_notation_mobile/env.dart';
import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: Env.BASE_URL,
  connectTimeout: 30000,
);

final dio = Dio(options);