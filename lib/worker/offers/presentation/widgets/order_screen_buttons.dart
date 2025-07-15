import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constant/textStyles.dart';
import '../../../../../common/resources/gen/locale_keys.g.dart';

class OrderScreenButtons extends StatefulWidget{

  const OrderScreenButtons({super.key});
  @override
  State<OrderScreenButtons> createState() {

    return _OrderScreenButtons();
  }
}

class _OrderScreenButtons extends State<OrderScreenButtons>{
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r)
      ),
      height: 57.h,
      padding: EdgeInsetsDirectional.only(
          start: 16.w, end: 16.w,
          top: 8.h,bottom: 8.h
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Expanded(
           child: AppButton(
             borderColor: context.appColors.primary,
             textStyle: TextStyles.semiBold14(
               color: Colors.white,
               context: context
             ),
             isBordered: true,
             backgroundColor: context.appColors.primary,
               text: context.tr(LocaleKeys.OrderScreen_previous_orders),
             onClick: (){},
           ),
         ),
          SizedBox(width: 12.w,),
          Expanded(
            child: AppButton(
              borderColor: context.appColors.primary,
              textStyle: TextStyles.semiBold14(
                  color: context.appColors.primary,
                  context: context
              ),
              isBordered: true,
                backgroundColor:  Colors.white,
                text: context.tr(LocaleKeys.OrderScreen_current_orders),
                textColor: context.appColors.primary,
                onClick: (){},
            ),
          ),
        ],
      ),
    );
  }
}
