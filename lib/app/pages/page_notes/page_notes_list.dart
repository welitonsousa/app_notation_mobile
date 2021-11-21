import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_empty.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_error.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_loading.dart';
import 'package:app_notation_mobile/app/models/model_state.dart';
import 'package:app_notation_mobile/app/pages/page_notes/view_modal_delete_note.dart';
import 'package:app_notation_mobile/app/pages/page_notes/page_notes_form.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/utils/formatters.dart';
import 'package:flutter/material.dart';

class PageNotes extends StatefulWidget {
  @override
  _PageNotesState createState() => _PageNotesState();
}

class _PageNotesState extends State<PageNotes> {
  final controller = ControllerNotes.instance;

  @override
  initState() {
    controller.getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notas"), bottom: search(), elevation: 0),
      body: AnimatedBuilder(animation: controller, builder: (context, snapshot) => body),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigator.push(
            MaterialPageRoute(
              builder: (BuildContext context) => PageNotesForm(),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget search() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 70),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomField(
          placeholder: "Pesquisar",
          textInputAction: TextInputAction.search,
          controller: controller.editSearch,
          onChange: controller.search,
          icon: IconButton(
            icon: Icon(Icons.close),
            onPressed: controller.clearSearch,
          ),
        ),
      ),
    );
  }

  Widget get body {
    if (controller.state == ModelState.loading) {
      return CustomCircular(size: 40);
    } else if (controller.state == ModelState.error) {
      return CustomError(action: () => controller.getNotes(isReload: true));
    } else if (controller.notes.isEmpty) {
      return CustomEmpty(action: () => controller.getNotes(isReload: true));
    }

    return RefreshIndicator(
      onRefresh: () => controller.getNotes(isReload: true),
      child: ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: controller.notes.length,
        itemBuilder: (context, index) {
          return itemNote(controller.notes[index]);
        },
      ),
    );
  }

  Widget itemNote(ModelNotes note) {
    String date = note.dateUpdate;
    if (date.isEmpty) date = note.date;
    return CustomCard(
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(Formatters.dateFormat(date)),
        trailing: deleteItem(note),
        onTap: () {
          FocusScope.of(context).unfocus();
          navigator.push(
            MaterialPageRoute(
              builder: (BuildContext context) => PageNotesForm(note: note),
            ),
          );
        },
      ),
    );
  }

  Widget deleteItem(ModelNotes note) {
    return IconButton(
      icon: Icon(Icons.delete, color: AppColors.danger),
      onPressed: () {
        showDialog(
          context: navigator.context,
          builder: (context) => ViewModalDeleteNote(note: note),
        );
      },
    );
  }
}
