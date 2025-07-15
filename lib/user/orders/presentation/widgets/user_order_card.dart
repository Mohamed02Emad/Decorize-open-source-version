import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:decorizer/common/widget/app/widget_ripple.dart';
import 'package:decorizer/common/widget/spaces.dart';
import 'package:decorizer/user/orders/domain/models/order_model.dart';
import 'package:decorizer/user/orders/presentation/screens/user_order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class UserOrderCard extends StatelessWidget {
  const UserOrderCard({
    super.key,
    required this.order,
    this.onDeleteOrder,
  });
  final OrderModel order;
  final Function(OrderModel)? onDeleteOrder;

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
        backgroundColor: context.appColors.onBackground ,
        padding: EdgeInsets.zero,
        radius: 12.r,
        child: Container(
          padding: EdgeInsetsDirectional.only(
              start: 12.w, end: 12.w, top: 8.h, bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImage(
                height: 90.h,
                width: 90.h,
                fit: BoxFit.cover,
                radius: 8.r,
                path: order.files.first.url,
              ).fadeScaleAppear(),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          order.title,
                          style: TextStyles.regular13(
                            context: context,
                          ),
                        ),
                        Spacer(),
                        Text(
                          order.budget.currency,
                          style: TextStyles.semiBold14(
                              context: context,
                              color: context.appColors.primary),
                        ).fadeAppear()
                      ],
                    ),
                    Height(6.h),
                    ReadMoreText(
                      order.content,
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      trimCollapsedText:
                          context.tr(LocaleKeys.OrderScreen_read_more),
                      trimExpandedText:
                          context.tr(LocaleKeys.OrderScreen_show_less),
                      style: TextStyles.regular12(
                          context: context, color: context.appColors.hintText),
                      colorClickableText: context.appColors.primary,
                    ),
                    Height(8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        WidgetRipple(
                          onClick: () {
                            _goToAdDetailsScreen();
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: 4.0.h, top: 4.h, bottom: 4.h),
                            child: Container(
                              padding: EdgeInsets.only(
                                bottom: 2.h,
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: context.appColors.primary,
                                width: 1.4.w,
                              ))),
                              child: Text(
                                  context
                                      .tr(LocaleKeys.OrderScreen_show_details),
                                  textAlign: TextAlign.right,
                                  style: TextStyles.regular12(
                                    context: context,
                                    color: context.appColors.primary,
                                  )).fittedBox(fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        Text(
                          order.status.displayName.tr(),
                          style: TextStyles.regular12().copyWith(
                            color: order.status.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _goToAdDetailsScreen() {
    Nav.push(UserOrderDetailsScreen(orderId: order.id)).then(
      (result) {
        if (result != null && result["action"] == "delete_order") {
          onDeleteOrder?.call(order);
        }
      },
    );
  }
}
