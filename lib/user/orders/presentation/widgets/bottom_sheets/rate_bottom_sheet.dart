import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/validator.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/constant/textStyles.dart';
import '../../../../../common/di/injection_container.dart';
import '../../../../../common/util/ui_helper.dart';
import '../../cubits/add_rate/add_rate_cubit.dart';


class RateBottomSheet extends StatefulWidget {
  const RateBottomSheet._({required this.id, super.key});
  final int id;

  static void show({
    required BuildContext context,
    required int id,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:  context.appColors.onBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return RateBottomSheet._(id: id);
      },
    );
  }

  @override
  State<RateBottomSheet> createState() => _RateBottomSheetState();
}

class _RateBottomSheetState extends State<RateBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => sl<AddRateCubit>(),
        child: Builder(
          builder: (context) => _cancelForm(context),
        )
    );
  }

  Widget _cancelForm(BuildContext context) {
    final cubit = context.read<AddRateCubit>();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsetsDirectional.only(
              start: 20.w,
              end: 20.w,
              top: 20.h,
              bottom: 20.h,
            ),
            child: Wrap(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        'اضف تقييمك',
                        style: TextStyles.semiBold16(),
                      ),
                      SizedBox(height: 20.h),
                      RatingBar(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 30.0,
                        updateOnDrag: true,
                        ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: Colors.amber),
                          half: Icon(Icons.star_half, color: Colors.amber),
                          empty: Icon(Icons.star_border, color: Colors.amber),
                        ),
                        onRatingUpdate: (rating) {
                          cubit.rate = rating.toInt();
                        },
                      ),
                      SizedBox(height: 20.h),
                      AppTextField(
                        title:'اكتب تعليقا',
                        hint: '',
                        validator: (value) => Validator.comment(value),
                        inputType: TextInputType.text,
                        maxLines: 4,
                        controller: cubit.rateCommentController,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: BlocConsumer<AddRateCubit, AddRateState>(
                              listener: (context, state) {
                                state.addRateState.listen(
                                  onSuccess: (data, message) {
                                    _closeAddRateBottomSheet(context);
                                  },
                                  onError: showErrorToast,
                                );
                              },
                              builder: (context, state) => AppButton(
                                backgroundColor: context.appColors.primary,
                                text: context.tr(LocaleKeys.action_send),
                                onClick: () => _submitRate(context),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: AppButton(
                              text: context.tr(LocaleKeys.action_cancel),
                              isBordered: true,
                              backgroundColor: Colors.white,
                              borderColor: context.appColors.primary,
                              textColor: context.appColors.primary,
                              onClick: _closeAddRateBottomSheet,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitRate(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
    context.read<AddRateCubit>().AddRate(workerId: widget.id);
    }
  }
  void _closeAddRateBottomSheet(BuildContext context) {
    Navigator.pop(context);
  }
}
