import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class EvaluationButton extends StatefulWidget{

  const EvaluationButton({super.key});
  @override
  State<EvaluationButton> createState() {
    return _EvaluationButton();
  }
}

class _EvaluationButton extends State<EvaluationButton>{


  @override
  Widget build(BuildContext context) {
    return AppButton(
      height: 32.h,
        text: context.tr(LocaleKeys.OrderScreen_evaluation),
        onClick: (){});
  }
}