import 'dart:convert';
import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/models/model_user.dart';
import 'package:app_notation_mobile/app/repository/repository_user.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/dio.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/env.dart';
import 'package:app_notation_mobile/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ControllerProfile extends ChangeNotifier {
  static final instance = ControllerProfile();
  final repo = RepositoryUser();
  late ModelUser user;

  Future<void> getMe() async {
    final _user = await repo.getMe();
    user.picture = _user.picture;
    user.user = _user.user;
    await prefs.setString("user", jsonEncode(user.toJson()));

    notifyListeners();
  }

  Future<void> loadUser() async {
    final data = prefs.getString("user") ?? "{}";
    final json = jsonDecode(data);
    user = ModelUser.fromJson(json);
    dio.options.headers = {"Authorization": "Bearer ${user.token}"};
  }

  Future<void> logOut() async {
    await prefs.setString("user", "{}");
    ControllerNotes.instance = ControllerNotes();
    navigator.popUntil(ModalRoute.withName(NamedRoutes.WELCOME));
    dio.options = options;
    navigator.pushNamed(NamedRoutes.WELCOME);
  }

  Future<void> sendEmail() async {
    try {
      final Uri emailLaunchUri = Uri(scheme: 'mailto', path: Env.EMAIL_APP);
      await launch(emailLaunchUri.toString());
    } catch (e) {
      CustomSnackbar.show(text: "Algo deu errado", background: AppColors.danger);
    }
  }

  bool loadingImage = false;
  Future openGallery({ImageSource imageSource = ImageSource.gallery}) async {
    try {
      final ImagePicker picker = ImagePicker();

      final image = await picker.pickImage(source: imageSource, );
      if (image != null) {
        this.loadingImage = true;
        notifyListeners();
        final link = await repo.sendFile(image.path);
        instance.user.picture = link;
        await prefs.setString("user", jsonEncode(user.toJson()));

        CustomSnackbar.show(text: "Foto de perfil atualizada");
      }
    } on DioError catch (e) {
      CustomSnackbar.error(e);
    } finally {
      loadingImage = false;
      notifyListeners();
    }
  }
}
