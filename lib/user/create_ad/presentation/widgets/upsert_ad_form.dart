import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/user/bottom_navigation/cubits/user_navigation_cubit.dart';
import 'package:decorizer/user/create_ad/presentation/cubits/upsert_ad/upsert_ad_cubit.dart';
import 'package:decorizer/user/create_ad/presentation/pages/upsert_ad_screen.dart';
import 'package:decorizer/user/create_ad/presentation/widgets/upsert_ad_drop_downs_section.dart';
import 'package:decorizer/user/create_ad/presentation/widgets/upsert_location_on_map_section.dart';
import 'package:decorizer/user/create_ad/presentation/widgets/upsert_pick_design_section.dart';
import 'package:decorizer/user/orders/domain/models/order_details_model.dart';
import 'package:decorizer/user/orders/presentation/cubits/get_orders/get_user_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/widget/app/app_button.dart';
import '../../../../common/widget/app/app_text_field.dart';
import '../../../../common/widget/spaces.dart';
import 'create_ad_success_bottom_sheet.dart';

class UpsertAdForm extends StatelessWidget {
  final OrderDetailsModel? orderDetailsModel;

  const UpsertAdForm({
    super.key,
    this.orderDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpsertAdCubit>();
    final isUpdating = orderDetailsModel != null;

    return Form(
      key: cubit.formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.only(
              top: 16.h, end: 16.w, start: 16.w, bottom: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const UpsertAdDropDownsSection(),
              Height(12.h),
              AppTextField(
                title: context.tr(LocaleKeys.create_ad_ad_name),
                inputType: TextInputType.text,
                hint: context
                    .tr(context.tr(LocaleKeys.create_ad_ad_name))
                    .enterHint,
                controller: cubit.nameController,
                validator: (value) => value?.isEmpty ?? true
                    ? context.tr(LocaleKeys.validation_empty_ad_name)
                    : null,
              ),
              Height(8.h),
              AppTextField(
                title: context.tr(LocaleKeys.create_ad_price),
                inputType: TextInputType.number,
                hint: context
                    .tr(context.tr(LocaleKeys.create_ad_price))
                    .enterHint,
                controller: cubit.priceController,
                validator: (value) => value?.isEmpty ?? true
                    ? context.tr(LocaleKeys.validation_empty_price)
                    : null,
              ),
              Height(12.h),
              const UpsertPickDesignSection(),
              Height(12.h),
              AppTextField(
                inputType: TextInputType.text,
                maxLines: 6,
                title: context.tr(LocaleKeys.create_ad_description),
                hint: context
                    .tr(context.tr(LocaleKeys.create_ad_description))
                    .enterHint,
                controller: cubit.descriptionController,
                validator: (value) => value?.isEmpty ?? true
                    ? context.tr(LocaleKeys.validation_empty_description)
                    : null,
              ),
              Height(16.h),
              const UpsertLocationOnMapSection(),
              Height(23.h),
              BlocConsumer<UpsertAdCubit, UpsertAdState>(
                listener: (context, state) => state.upsertAdState.listen(
                  onSuccess: (data, message) {
                    _onSaveAdSuccess(context, isUpdating);
                  },
                  onError: showErrorToast,
                ),
                builder: (context, state) => AppButton(
                  isLoading: state.upsertAdState.isLoading,
                  fontSize: 14.sp,
                  backgroundColor: context.appColors.primary,
                  rippleColor: context.appColors.splashColor,
                  text: context.tr(isUpdating
                      ? LocaleKeys.action_save
                      : LocaleKeys.action_create),
                  onClick: () {
                    _onSaveAdClicked(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSaveAdClicked(BuildContext context) {
    final cubit = context.read<UpsertAdCubit>();
    final isValidForm = cubit.formKey.currentState!.validate();
    if (isValidForm) {
      cubit.saveAd();
    }
  }

  void _onSaveAdSuccess(BuildContext context, bool isUpdating) {
    _refreshUserOrders(context);
    Nav.pop(context,
        result: {"action": isUpdating ? "update_ad" : "create_ad"});

    if (!isUpdating) {
      CreateAdSuccessBottomSheet.show(
        context: context,
        onCreateNewAd: () {
          Nav.push(const UpsertAdScreen());
        },
        onShowMyAds: () {
          sl<UserNavigationCubit>().setCurrentIndex(1);
        },
      );
    }
  }
}

void _refreshUserOrders(BuildContext context) {
  sl<GetUserOrdersCubit>().refresh();
}
