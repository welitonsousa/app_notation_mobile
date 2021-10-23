import 'package:app_notation_mobile/const/colors.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String image;
  const CustomAvatar({Key? key, this.image = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            border: Border.all(width: 10, color: AppColors.primary),
          ),
          child: Visibility(
            visible: this.image.isEmpty,
            child: Icon(
              Icons.person_outline,
              size: 200,
              color: AppColors.primary,
            ),
            replacement: ClipOval(
              child: Image.network(
                this.image,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
