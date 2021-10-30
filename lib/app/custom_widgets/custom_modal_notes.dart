import 'package:app_notation_mobile/app/controllers/controller_dialog_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_buttom.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';

class CustomDialogNotes extends StatefulWidget {
  final ModelNotes? note;
  CustomDialogNotes({this.note});

  @override
  _CustomDialogNotesState createState() => _CustomDialogNotesState();
}

class _CustomDialogNotesState extends State<CustomDialogNotes> {
  final controller = ControllerNotesDialog();

  @override
  void initState() {
    controller.initNote(this.widget.note);
    super.initState();
  }

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
                      this._inputs(),
                      this._actions(),
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

  Widget _inputs() {
    return Form(
      key: controller.form,
      child: Column(
        children: [
          CustomField(
            label: "Titulo",
            enable: !controller.loading,
            controller: controller.editTitle,
            validator: (value) => Validations.generic(value: value),
          ),
          CustomField(
            label: "Nota",
            maxLines: 8,
            minLines: 3,
            enable: !controller.loading,
            controller: controller.editBody,
            textInputType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            validator: (value) => Validations.generic(value: value),
          ),
        ],
      ),
    );
  }

  Widget _actions() {
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
            label: "Salvar",
            loading: controller.loading,
            onPressed: controller.saveNote,
          ),
        )
      ],
    );
  }
}
