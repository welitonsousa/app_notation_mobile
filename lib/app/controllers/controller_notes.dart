import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/app/repository/repository_notes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ControllerNotes extends ChangeNotifier {
  static ControllerNotes instance = ControllerNotes();

  final repository = RepositoryNotes();

  List<ModelNotes> notes = [];
  bool loading = false;

  Future<void> getNotes({bool isReload = false}) async {
    try {
      if (notes.isEmpty || isReload) {
        if (!isReload) loading = true;
        notifyListeners();
        notes = await repository.getNotes();
      }
    } on DioError catch (e) {
      CustomSnakbar.error(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  bool loadingDelete = false;
  Future<bool> deleteNote(String id) async {
    try {
      loadingDelete = true;
      notifyListeners();
      await repository.deleteNote(id);
      instance.notes.removeWhere((e) => e.id == id);
      instance.notifyListeners();
      CustomSnakbar.show(text: "Nota deletada");
      return true;
    } on DioError catch (e) {
      CustomSnakbar.error(e);
    } finally {
      loadingDelete = false;
      notifyListeners();
    }
    return false;
  }
}
