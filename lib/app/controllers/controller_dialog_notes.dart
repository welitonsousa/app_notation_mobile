
import 'dart:async';

import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_snack.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/app/repository/repository_notes.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ControllerNotesDialog extends ChangeNotifier {
  final editBody = TextEditingController();
  final editTitle = TextEditingController();
  final form = GlobalKey<FormState>();
  final repo = RepositoryNotes();

  bool loading = false;
  String id = "";

  void initNote(ModelNotes? note) {
    if (note != null) {
      this.id = note.id;
      this.editBody.text = note.body;
      this.editTitle.text = note.title;
    }
  }

  Future<void> updateNote() async {
    await repo.updateNote(loadNote());
    await ControllerNotes.instance.getNotes(isReload: true);

    CustomSnackbar.show(text: "Nota atualizada com sucesso");
  }

  Future<void> createNote() async {
    await repo.createNote(loadNote());
    await ControllerNotes.instance.getNotes(isReload: true);

    CustomSnackbar.show(text: "Nota cadastrada com sucesso");
  }

  ModelNotes loadNote() {
    return ModelNotes(
      body: editBody.text,
      title: editTitle.text,
      id: this.id,
      date: "",
      userId: "",
    );
  }

  Future<void> saveNote() async {
    if (form.currentState?.validate() ?? false) {
      try {
        this.loading = true;
        notifyListeners();
        if (this.id.isNotEmpty)
          await updateNote();
        else
          await createNote();
        navigator.pop();
      } on DioError catch (e) {
        CustomSnackbar.error(e);
      } finally {
        this.loading = false;
        Timer.run(() => notifyListeners());
      }
    }
  }
}
