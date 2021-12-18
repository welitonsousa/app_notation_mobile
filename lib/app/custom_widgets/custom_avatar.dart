import 'package:app_notation_mobile/app/controllers/controller_profile.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_button_sheet.dart';
import 'package:app_notation_mobile/app/custom_widgets/custom_loading.dart';
import 'package:app_notation_mobile/app/pages/page_view_image.dart';
import 'package:app_notation_mobile/const/colors.dart';
import 'package:app_notation_mobile/const/routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                child: const CustomCircular(size: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(width: 10, color: AppColors.primary),
                ),
              ),
              replacement: GestureDetector(
                onTap: showActions,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(width: 10, color: AppColors.primary),
                  ),
                  child: Visibility(
                    visible: image.isEmpty,
                    child: _localAvatar,
                    replacement: _networkAvatar,
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
    return const Icon(
      Icons.person_outline,
      size: 200,
      color: AppColors.primary,
    );
  }

  Widget get _networkAvatar {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: CachedNetworkImage(
        imageUrl: image,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
        progressIndicatorBuilder: _loadingImage,
        errorWidget: (context, url, error) => _localAvatar,
      ),
    );
  }

  Widget _loadingImage(context, url, downloadProgress) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Center(
          child: CircularProgressIndicator(value: downloadProgress.progress)),
    );
  }

  void showActions() {
    ButtonSheet.showMenuBottomSheet(
      title: "Imagem de perfil",
      options: [
        Visibility(
          visible: image.isNotEmpty,
          child: TextButton(
            child: const Text("Ver imagem"),
            onPressed: () {
              navigator.pop();
              navigator.push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PageViewImage(image),
                ),
              );
            },
          ),
        ),
        TextButton(
          child: const Text("Nova imagem"),
          onPressed: imageDirectory,
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
          child: const Text("Galeria"),
          onPressed: () {
            navigator.pop();
            controller.openGallery();
          },
        ),
        TextButton(
          child: const Text("Camera"),
          onPressed: () {
            navigator.pop();
            controller.openGallery(imageSource: ImageSource.camera);
          },
        ),
      ],
    );
  }
}
