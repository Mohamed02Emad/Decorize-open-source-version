import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../common/constant/app_svgs.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({super.key});
  @override
  State<SearchButton> createState() {
    return _SearchButton();
  }
}

class _SearchButton extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        height: 16.h,
        width: 16.w,
        AppSvgs.search,
        colorFilter: context.isDarkMode ? context.appColors.text.colorFilter : context.appColors.primary.colorFilter,
    );
  }
}
