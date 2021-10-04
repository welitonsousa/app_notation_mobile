import 'package:app_notation_mobile/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircular extends StatelessWidget {
  final Color color;
  final double size;
  CustomCircular({this.color = AppColors.primary, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: this.size,
        width: this.size,
        child: CircularProgressIndicator(
          key: Key('animation-loading'),
          valueColor: AlwaysStoppedAnimation<Color>(this.color),
        ),
      ),
    );
  }
}