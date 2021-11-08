import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';

class ButtomSheet {
  static Future showMenuBottomSheet({
    required String title,
    required List<Widget> options,
  }) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      isScrollControlled: true,
      context: navigator.context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 14, bottom: 15),
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: <Widget>[
                  BackButton(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 35),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 30),
              Container(
                // height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: options,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
