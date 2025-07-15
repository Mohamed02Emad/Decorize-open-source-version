import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_text_field.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:decorizer/common/widget/form_to_box_adapter.dart';
import 'package:decorizer/common/widget/location_map.dart';
import 'package:decorizer/common/widget/pick_location_screen.dart';
import 'package:decorizer/user/create_ad/presentation/cubits/create_ad/create_ad_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationOnMapSection extends StatelessWidget {
  const LocationOnMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateAdCubit>();
    return ValueListenableBuilder(
        valueListenable: cubit.userLocationNotifier,
        builder: (context, userLocation, child) => Column(
              children: [
                FormToBoxAdapter(
                  value: userLocation,
                  validator: (value) => userLocation == null
                      ? context.tr(LocaleKeys.validation_empty_address)
                      : null,
                  child: DynamicContainer(
                    child: userLocation != null
                        ? SizedBox(
                            height: 160.h,
                            width: double.infinity,
                            child: LocationMap(
                              key: ValueKey(userLocation.toJson()),
                              latlng: userLocation,
                              onClick: () {
                                _openLocationPicker(context);
                              },
                            ),
                          ).withTitle(
                            titleHorizontalPadding: 0,
                            titleStyle: TextStyles.semiBold12(
                              context: context,
                            ),
                            title: context.tr(LocaleKeys.create_ad_address))
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.h),
                            child: Container(
                              padding: EdgeInsets.only(
                                bottom: 5.h,
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: context.isDarkMode ? context.appColors.text : context.appColors.primary,
                                width: 1.4.w,
                              ))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    height: 23.h,
                                    width: 23.w,
                                    AppSvgs.location,
                                    fit: BoxFit.contain,
                                    colorFilter: context.isDarkMode ? context.appColors.text.colorFilter :
                                        context.appColors.primary.colorFilter,
                                  ),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  Text(
                                    context.tr(LocaleKeys.create_ad_address),
                                    textAlign: TextAlign.right,
                                    style: TextStyles.regular14Weight400(
                                      context: context,
                                      color: context.isDarkMode ? context.appColors.text : context.appColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).clickable(() => _openLocationPicker(context)),
                  ),
                ),
                DynamicContainer(
                  showChild: userLocation != null,
                  child: AppTextField(
                      // title:
                      //     context.tr(LocaleKeys.create_ad_location_description),
                      hint: LocaleKeys.create_ad_location_description
                          .tr()
                          .enterHint,
                      controller: cubit.locationDescriptionController).marginTop(8.h),
                ),
              ],
            ));
  }

  void _openLocationPicker(BuildContext context) {
    final cubit = context.read<CreateAdCubit>();
    Nav.push(PickLocationScreen(
      initialLocation: cubit.userLocationNotifier.value,
      onSaveLocation: (location) {
        cubit.userLocationNotifier.value = location;
      },
    ));
  }
}
