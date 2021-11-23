import 'package:app_notation_mobile/app/controllers/controller_dialog_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class PageNotesForm extends StatefulWidget {
  final ModelNotes? note;

  PageNotesForm({this.note});

  @override
  _PageNotesFormState createState() => _PageNotesFormState();
}

class _PageNotesFormState extends State<PageNotesForm> {
  final focusTitle = new FocusNode();
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
          bottomNavigationBar: this._actions,
          body: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              this._inputs(),
              Container(height: 100),
            ],
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
            focus: this.focusTitle,
            enable: !controller.loading,
            controller: controller.editTitle,
            validator: (value) => Validations.generic(value: value),
          ),
          GestureDetector(
            onTap: () => FocusScope.of(context).nextFocus(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black45),
              ),
              padding: const EdgeInsets.all(3),
              child: HtmlEditor(
                controller: controllerEditor,
                callbacks: Callbacks(
                  onFocus: () => FocusScope.of(context).nextFocus(),
                  onChangeContent: (value) {
                    controller.editBody.text = value ?? '';
                  },
                ),
                otherOptions: OtherOptions(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                ),

                htmlEditorOptions: HtmlEditorOptions(initialText: controller.editBody.text),
                htmlToolbarOptions: HtmlToolbarOptions(
                  defaultToolbarButtons: [
                    FontButtons(clearAll: false),
                    ColorButtons(),
                    ListButtons(listStyles: true),
                    ParagraphButtons(textDirection: false, lineHeight: false, caseConverter: false),
                    InsertButtons(
                      picture: false,
                      link: false,
                      video: false,
                      audio: false,
                      hr: false,
                      otherFile: false,
                    ),
                    StyleButtons(),
                    FontSettingButtons(fontSizeUnit: false),
                  ],
                  toolbarPosition: ToolbarPosition.belowEditor,
                  buttonBorderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _actions {
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
