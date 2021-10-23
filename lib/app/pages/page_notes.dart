import 'package:flutter/material.dart';

class PageNotes extends StatefulWidget {
  const PageNotes({ Key? key }) : super(key: key);

  @override
  _PageNotesState createState() => _PageNotesState();
}

class _PageNotesState extends State<PageNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Text("Pagina de notas"),
    );
  }
}