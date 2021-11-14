import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
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

  bool loading = false;
  bool error = false;

  void clearSearch() {
    this.editSearch.clear();
    this.notes = [...this.notesOriginal];
    notifyListeners();
  }

  void search(String value) {
    String search = value.toLowerCase();
    notes = notesOriginal.where((e) {
      return e.title.toLowerCase().contains(search) || e.body.toLowerCase().contains(search);
    }).toList();
    notifyListeners();
  }

  Future<void> getNotes({bool isReload = false, bool clean = false}) async {
    if (clean) {
      notesOriginal.clear();
      notes.clear();
    }
    try {
      if (this.notesOriginal.isEmpty || isReload) {
        if (!isReload) this.loading = true;
        this.error = false;
        notifyListeners();
        this.notesOriginal = await this.repository.getNotes();
        this.notes = [...this.notesOriginal];
      }
    } on DioError catch (e) {
      this.error = true;
      CustomSnackbar.error(e);
    } finally {
      this.loading = false;
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
