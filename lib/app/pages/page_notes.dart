import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_loading.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_modal_notes.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';

class PageNotes extends StatefulWidget {
  const PageNotes({Key? key}) : super(key: key);

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

  PreferredSizeWidget search() {
    return PreferredSize(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: CustomField(
          placeholder: "Pesquisar",
          textInputAction: TextInputAction.search,
          controller: controller.editSearch,
          onChange: controller.seach,
          icon: IconButton(
            icon: Icon(Icons.close),
            onPressed: controller.clearSearch,
          ),
        ),
      ),
      preferredSize: Size(double.infinity, 33),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(bottom: search()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: navigator.context,
            builder: (context) => CustomDialogNotes(),
          );
        },
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return body;
        },
      ),
    );
  }

  Widget get body {
    if (controller.loading) return CustomCircular();
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
    return CustomCard(
      child: ListTile(
        title: Text(note.title),
        trailing: deleteItem(note),
        onTap: () {
          FocusScope.of(context).unfocus();
          showDialog(
            context: navigator.context,
            builder: (context) => CustomDialogNotes(note: note),
          );
        },
      ),
    );
  }

  Widget deleteItem(ModelNotes note) {
    final controllerDelete = ControllerNotes();
    return AnimatedBuilder(
      animation: controllerDelete,
      builder: (context, widget) {
        return Visibility(
          visible: !controllerDelete.loadingDelete,
          replacement: Container(width: 40, child: CustomCircular(color: AppColors.danger)),
          child: IconButton(
            icon: Icon(Icons.delete, color: AppColors.danger),
            onPressed: () => controllerDelete.deleteNote(note.id),
          ),
        );
      },
    );
  }
}
