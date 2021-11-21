import 'package:app_notation_mobile/const/images.dart';
import 'package:flutter/material.dart';

class CustomEmpty extends StatelessWidget {
  final Future<void> Function() action;
  const CustomEmpty({required this.action});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: this.action,
      child: ListView(
        children: [
          Container(height: MediaQuery.of(context).size.height * .25),
          Center(child: Image.asset(AppImages.CLIP_BOARD, height: 100)),
          Container(height: 20),
          Center(child: Text("Lista vazia", style: TextStyle(fontSize: 22))),
        ],
      ),
    );
  }
}
