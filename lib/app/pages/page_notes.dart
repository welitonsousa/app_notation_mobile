import 'package:app_notation_mobile/app/controllers/controller_notes.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_card.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_loading.dart';
import 'package:app_notation_mobile/app/models/model_notes.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return _body();
        },
      ),
    );
  }

  Widget _body() {
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
      ),
    );
  }
}
