import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';

class ViewModalDeleteNote extends StatefulWidget {
  final ModelNotes note;
  ViewModalDeleteNote({required this.note});

  @override
  _ViewModalDeleteNoteState createState() => _ViewModalDeleteNoteState();
}

class _ViewModalDeleteNoteState extends State<ViewModalDeleteNote> {
  final controller = ControllerNotes();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return Container(
            constraints: BoxConstraints(maxHeight: 500),
            child: Scrollbar(
              isAlwaysShown: true,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Container(height: 20),
                      this._inputs,
                      Container(height: 20),
                      this._actions,
                      Container(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _inputs {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Icon(Icons.warning_amber_rounded, size: 50, color: AppColors.danger),
          Container(height: 20),
          Text(
            "Você deseja realmente deletar essa anotação?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget get _actions {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            label: "Cancelar",
            backgroundColor: AppColors.danger,
            onPressed: navigator.pop,
          ),
        ),
        Container(width: 10),
        Expanded(
          child: CustomButton(
            label: "Deletar",
            loading: controller.loadingDelete,
            onPressed: () => controller.deleteNote(this.widget.note.id),
          ),
        )
      ],
    );
  }
}
