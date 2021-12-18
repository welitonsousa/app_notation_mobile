import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_empty.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_error.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_field.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_loading.dart';
import 'package:app_notation_mobile/app/pages/page_notes/view_modal_delete_note.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:app_notation_mobile/main.dart';
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
    _fastAction();
    super.initState();
  }

  void _fastAction() {
    if (fastAction == "new_note") {
      fastAction = "";
      Future.delayed(const Duration(milliseconds: 500)).then((e) {
        navigator.pushNamed(NamedRoutes.NOTE_FORM);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Notas"), bottom: search(), elevation: 0),
      body: AnimatedBuilder(
          animation: controller, builder: (context, snapshot) => body),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => navigator.pushNamed(NamedRoutes.NOTE_FORM)),
    );
  }

  PreferredSizeWidget search() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 70),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomField(
          placeholder: "Pesquisar",
          textInputAction: TextInputAction.search,
          controller: controller.editSearch,
          onChange: controller.search,
          icon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: controller.clearSearch,
          ),
        ),
      ),
    );
  }

  Widget get body {
    if (controller.state == ModelState.loading) {
      return const CustomCircular(size: 40);
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
          navigator.pushNamed(NamedRoutes.NOTE_FORM, arguments: {"note": note});
        },
      ),
    );
  }

  Widget deleteItem(ModelNotes note) {
    return IconButton(
      icon: const Icon(Icons.delete, color: AppColors.danger),
      onPressed: () {
        showDialog(
          context: navigator.context,
          builder: (context) => ViewModalDeleteNote(note: note),
        );
      },
    );
  }
}
