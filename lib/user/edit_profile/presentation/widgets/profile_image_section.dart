import 'dart:io';

import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/util/get_file/widgets/select_image_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImageSection extends StatelessWidget {
  final File? profileImage;
  final String? profileImageUrl;
  final Function(File?) onImageSelected;

  const ProfileImageSection({
    super.key,
    this.profileImage,
    this.profileImageUrl,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SelectFileButton.roundedImage(
      imageFile: profileImage,
      imageUrl: profileImageUrl,
      imageSize: 110.h.size,
      onImageSelected: onImageSelected,
    ).marginHorizontal(16.w).marginVertical(12.h);
  }
}
