import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_loading.dart';
import 'package:app_notation_mobile/app/pages/page_notes/view_modal_delete_note.dart';
import 'package:app_notation_mobile/app/pages/page_notes/view_modal_edit_notes.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/images.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/utils/formatters.dart';
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

  PreferredSizeWidget search() {
    return PreferredSize(
      child: Container(
        padding: const EdgeInsets.all(10),
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
      preferredSize: Size(double.infinity, 33),
    );
  }

  Widget get body {
    if (controller.loading) {
      return CustomCircular(size: 40);
    } else if (controller.error) {
      return this.error;
    } else if (controller.notes.isEmpty) {
      return emptyList;
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

  Widget get error {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Icon(Icons.error_outline, color: AppColors.danger, size: 70)),
        Container(height: 20),
        Center(child: Text("Algo deu errado", style: TextStyle(fontSize: 20))),
        Center(
          child: TextButton(
            child: Text("Tente novamente"),
            onPressed: () => controller.getNotes(clean: true),
          ),
        ),
      ],
    );
  }

  Widget get emptyList {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset(AppImages.CLIP_BOARD, height: 100)),
        Container(height: 20),
        Center(child: Text("Lista vazia", style: TextStyle(fontSize: 22))),
      ],
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
          showDialog(
            context: navigator.context,
            builder: (context) => CustomDialogNotes(note: note),
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
