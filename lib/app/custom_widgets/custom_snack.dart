import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show({required String text, Color? background}) {
    ScaffoldMessenger.of(navigator.context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: background ?? AppColors.success,
        content: Container(
          height: 30,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  static void error(DioError e) {
    String? message = e.response?.data["message"];
    ScaffoldMessenger.of(navigator.context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.danger,
        content: Container(
          height: 30,
          child: Center(
            child: Text(
              message ?? "Ops, algo deu errado!",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
