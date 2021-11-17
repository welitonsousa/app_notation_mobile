import 'package:app_notation_mobile/app/controllers/controller_dialog_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class CustomDialogNotes extends StatefulWidget {
  final ModelNotes? note;
  CustomDialogNotes({this.note});

  @override
  _CustomDialogNotesState createState() => _CustomDialogNotesState();
}

class _CustomDialogNotesState extends State<CustomDialogNotes> {
  final controller = ControllerNotesDialog();
  HtmlEditorController controllerEditor = HtmlEditorController();

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
    return AnimatedBuilder(
      animation: controller,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(title: Text("Nota")),
          bottomNavigationBar: this._actions(),
          body: Scrollbar(
            isAlwaysShown: true,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                this._inputs(),
                Container(height: 100),
              ],
            ),
          ),
        );
      },
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
          HtmlEditor(
            controller: controllerEditor,
            callbacks: Callbacks(
              onChangeContent: (value) {
                controller.editBody.text = value ?? '';
              },
            ),
            htmlEditorOptions: HtmlEditorOptions(
              initialText: controller.editBody.text,
            ),
            htmlToolbarOptions: HtmlToolbarOptions(toolbarType: ToolbarType.nativeGrid),
          ),

          // CustomField(
          //   label: "Nota",
          //   maxLines: 8,
          //   minLines: 3,
          //   enable: !controller.loading,
          //   controller: controller.editBody,
          //   textInputType: TextInputType.multiline,
          //   textInputAction: TextInputAction.newline,
          //   validator: (value) => Validations.generic(value: value),
          // ),
        ],
      ),
    );
  }

  Widget _actions() {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(10),
      child: Row(
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
      ),
    );
  }
}
