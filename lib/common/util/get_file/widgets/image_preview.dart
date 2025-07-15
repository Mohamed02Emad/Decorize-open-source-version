import 'package:decorizer/common/util/get_file/widgets/zoomable_local_image.dart';
import 'package:decorizer/common/util/get_file/widgets/zoomable_network_image.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imageName;
  final String? url;
  final String? localImagePath;
  final String? heroTag;

  const ImagePreviewScreen(
      {super.key,
      required this.imageName,
      this.url,
      this.localImagePath,
      this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        title: imageName.length > 20 ? '${imageName.substring(0, 20)}...' : imageName,
        hasBackButton: true,
      ),
      body: Column(
        children: <Widget>[
          if (localImagePath != null)
            Expanded(
              child: heroTag == null ? ZoomableLocalImage(
                imagePath: localImagePath!,
              ) : Hero(
                tag: heroTag!,
                child: ZoomableLocalImage(
                  imagePath: localImagePath!,
                ),
              ),
            ),
          if (url != null && localImagePath == null)
            Expanded(
              child: heroTag == null ? ZoomableNetworkImage(
                imageUrl: url!,
              ) : Hero(
                tag: heroTag!,
                child: ZoomableNetworkImage(
                  imageUrl: url!,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
