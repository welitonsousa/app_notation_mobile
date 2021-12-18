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
    Key? key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('custom-button'),
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: () {
          if (onPressed != null && !loading) onPressed!();
        },
        child: Visibility(
          visible: loading,
          child: const CustomCircular(color: AppColors.white),
          replacement: Text(
            label,
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
