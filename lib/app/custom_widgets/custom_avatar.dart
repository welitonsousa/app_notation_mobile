import 'package:app_notation_mobile/app/controllers/controller_profile.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button_sheet.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_loading.dart';
import 'package:app_notation_mobile/app/pages/page_view_image.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomAvatar extends StatelessWidget {
  final String image;
  final controller = ControllerProfile.instance;

  CustomAvatar({Key? key, this.image = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget) {
        return Column(
          children: [
            Visibility(
              visible: controller.loadingImage,
              child: Container(
                width: 220,
                height: 220,
                child: CustomCircular(size: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(width: 10, color: AppColors.primary),
                ),
              ),
              replacement: GestureDetector(
                onTap: this.showActions,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(width: 10, color: AppColors.primary),
                  ),
                  child: Visibility(
                    visible: this.image.isEmpty,
                    child: this._localAvatar,
                    replacement: this._networkAvatar,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget get _localAvatar {
    return Icon(
      Icons.person_outline,
      size: 200,
      color: AppColors.primary,
    );
  }

  Widget get _networkAvatar {
    return ClipOval(
      child: Image.network(
        this.image,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => this._localAvatar,
        loadingBuilder: this._loadingImage,
      ),
    );
  }

  Widget _loadingImage(context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Container(
      height: 200,
      width: 200,
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
        ),
      ),
    );
  }

  void showActions() {
    ButtonSheet.showMenuBottomSheet(
      title: "Imagem de perfil",
      options: [
        Visibility(
          visible: this.image.isNotEmpty,
          child: TextButton(
            child: Text("Ver imagem"),
            onPressed: () {
              navigator.pop();
              navigator.push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PageViewImage(this.image),
                ),
              );
            },
          ),
        ),
        TextButton(
          child: Text("Nova imagem"),
          onPressed: this.imageDirectory,
        ),
      ],
    );
  }

  void imageDirectory() {
    navigator.pop();
    ButtonSheet.showMenuBottomSheet(
      title: "Escolha o local da imagem",
      options: [
        TextButton(
          child: Text("Galeria"),
          onPressed: () {
            navigator.pop();
            controller.openGallery();
          },
        ),
        TextButton(
          child: Text("Camera"),
          onPressed: () {
            navigator.pop();
            controller.openGallery(imageSource: ImageSource.camera);
          },
        ),
      ],
    );
  }
}
