import 'package:app_notation_mobile/const/colors.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final Function()? action;
  CustomError({required this.action});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Icon(Icons.error_outline, color: AppColors.danger, size: 70)),
        Container(height: 20),
        Center(child: Text("Algo deu errado", style: TextStyle(fontSize: 20))),
        Center(
          child: TextButton(
            child: Text("Tente novamente"),
            onPressed: this.action,
          ),
        ),
      ],
    );
  }
}
