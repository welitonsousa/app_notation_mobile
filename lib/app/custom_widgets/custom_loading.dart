import 'package:app_notation_mobile/const/colors.dart';
import 'package:flutter/material.dart';

class CustomCircular extends StatelessWidget {
  final Color color;
  final double size;
  const CustomCircular(
      {Key? key, this.color = AppColors.primary, this.size = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          key: const Key('animation-loading'),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
