import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/app/models/model_state.dart';
export 'package:app_notation_mobile/app/models/model_state.dart';
import 'package:app_notation_mobile/app/repository/repository_notes.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ControllerNotes extends ChangeNotifier {
  static ControllerNotes instance = ControllerNotes();

  final repository = RepositoryNotes();

  List<ModelNotes> notes = [];
  List<ModelNotes> notesOriginal = [];
  final editSearch = TextEditingController();

  ModelState state = ModelState.stope;

  void clearSearch() {
    editSearch.clear();
    notes = [...notesOriginal];
    notifyListeners();
  }

  void search(String value) {
    String search = value.toLowerCase();
    notes = notesOriginal.where((e) {
      return e.title.toLowerCase().contains(search) ||
          e.body.toLowerCase().contains(search);
    }).toList();
    notifyListeners();
  }

  Future<void> getNotes({bool isReload = false}) async {
    try {
      if (state == ModelState.stope || isReload) {
        if (!isReload || state == ModelState.error) state = ModelState.loading;
        notifyListeners();
        notesOriginal = await repository.getNotes();
        notes = [...notesOriginal];
        state = ModelState.success;
      }
    } on DioError catch (e) {
      state = ModelState.error;
      CustomSnackbar.error(e);
    } finally {
      notifyListeners();
    }
  }

  bool loadingDelete = false;
  Future<void> deleteNote(String id) async {
    try {
      loadingDelete = true;
      notifyListeners();
      await repository.deleteNote(id);
      instance.notes.removeWhere((e) => e.id == id);
      instance.notifyListeners();
      navigator.pop();
      CustomSnackbar.show(text: "Nota deletada");
    } on DioError catch (e) {
      CustomSnackbar.error(e);
    } finally {
      loadingDelete = false;
      notifyListeners();
    }
  }
}
