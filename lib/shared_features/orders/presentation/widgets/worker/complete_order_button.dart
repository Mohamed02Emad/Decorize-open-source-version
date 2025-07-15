import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CompleteButton extends StatefulWidget{

  const CompleteButton({super.key});
  @override
  State<CompleteButton> createState() {
    return _CompleteButton();
  }
}

class _CompleteButton extends State<CompleteButton>{


  @override
  Widget build(BuildContext context) {
    return AppButton(
        height: 36.h,
        text: context.tr(LocaleKeys.OrderScreen_complete),
        onClick: (){});
  }
}