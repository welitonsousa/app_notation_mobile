import 'package:app_notation_mobile/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PageViewImage extends StatelessWidget {
  final String link;
  const PageViewImage(this.link);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: CloseButton(color: AppColors.white),
      ),
      body: Container(
        child: PhotoView(
          enablePanAlways: true,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          imageProvider: NetworkImage(this.link),
        ),
      ),
    );
  }
}
