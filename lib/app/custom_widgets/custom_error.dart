import 'package:app_notation_mobile/const/colors.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final Function()? action;
  const CustomError({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.error_outline,
            color: AppColors.danger,
            size: 70,
          ),
        ),
        Container(height: 20),
        const Center(
          child: Text(
            "Algo deu errado",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Center(
          child: TextButton(
            child: const Text("Tente novamente"),
            onPressed: action,
          ),
        ),
      ],
    );
  }
}
