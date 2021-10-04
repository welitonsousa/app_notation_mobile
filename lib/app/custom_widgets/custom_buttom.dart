import 'package:app_notation_mobile/const/colors.dart';
import 'package:flutter/material.dart';
import 'custom_loading.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final bool loading;
  const CustomButton({
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('custom-button'),
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: this.onPressed ?? () {},
        child: Visibility(
          visible: loading,
          child: CustomCircular(color: AppColors.white),
          replacement: Text(
            this.label,
            style: TextStyle(color: textColor ?? AppColors.white),
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}