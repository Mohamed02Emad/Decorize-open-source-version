import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constant/app_svgs.dart';

class PleaseLoginWidget extends StatelessWidget {
  const PleaseLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppSvgs.loginFirst,
            width: 300.h,
            height: 300.h,
          ),
          Text(
            context.tr('please_login_first'),
            textAlign: TextAlign.center,
            style: TextStyles.bold18(),
          )
        ],
      ),
    );
  }
}
