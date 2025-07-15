import 'dart:io';
import 'dart:math';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/util/get_file/pick_file_util.dart';
import 'package:decorizer/common/util/get_file/picker_file_type.dart';
import 'package:decorizer/common/util/guest_util.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_error_widget.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/user/create_design/presentation/pages/create_design_by_your_self_screen.dart';
import 'package:decorizer/user/home/presentation/cubits/home/home_cubit.dart';
import 'package:decorizer/user/home/presentation/widgets/ads_slider.dart';
import 'package:decorizer/user/home/presentation/widgets/bottom_sheets/design_description_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../create_design/presentation/pages/create_design_screen.dart';
import '../../domain/enums/design_method.dart';
import '../widgets/bottom_sheets/design_method_bottom_sheet.dart';
import '../widgets/home_title_bar.dart';
import '../widgets/sections/previous_designs_section.dart';
import '../widgets/sections/suggested_designs_section.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => sl<HomeCubit>()
            ..getCategories()
            ..getSavedDesigns()),
    ], child: const _UserHomeScreenBody());
  }
}

class _UserHomeScreenBody extends StatelessWidget {
  const _UserHomeScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const HomeTitleBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              color: AppColors.white,
              backgroundColor: context.appColors.primary,
              child: SingleChildScrollView(
                controller: context.read<HomeCubit>().scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state.isHomeError) {
                      return AppErrorWidget(
                        errorMessage: state.categoriesState.message ??
                            state.categoriesImagesState.message ??
                            context.tr(LocaleKeys.error_error_happened),
                        onRefresh: () => _onRefresh(context),
                      )
                          .marginHorizontal(16.w)
                          .marginTop(100.h)
                          .marginBottom(200.h);
                    }
                    return Column(
                      children: [
                        12.h.gap,
                        const AdsSlider(),
                        12.h.gap,
                        if (GuestUtil.isGuest.not())
                          const PreviousDesignsSection(),
                        const SuggestedDesignsSection(),
                        const SizedBox(height: 140),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        text: context.tr(LocaleKeys.home_create_new_design),
        onClick: () => _createDesignClicked(context),
        icon: Icons.add,
        textColor: context.appColors.white,
        iconTint: context.appColors.white,
        margin: 16.edgeInsetsHorizontal.copyWith(bottom: 20.h),
      ),
    );
  }

  void _createDesignClicked(BuildContext context) async {
    GuestUtil.executeOrAskToLogin(
      function: () async {
        final File? selectedImage =
            await PickFileUtil.showSelectFileSourceBottomSheet(
          Nav.globalContext,
          fileType: PickerFileType.image,
        );
        if (selectedImage == null) return;
        DesignMethodBottomSheet.show(
          Nav.globalContext,
          onDesignMethodSelected: (designMethod) => onDesignMethodSelected(
              Nav.globalContext, designMethod, selectedImage),
        );
      },
      context: context,
    );
  }

  void onDesignMethodSelected(
      BuildContext context, DesignMethod designMethod, File selectedImage) {
    switch (designMethod) {
      case DesignMethod.suggest:
        {
          _openCreateDesignScreen(context, selectedImage, null);
          break;
        }
      case DesignMethod.designByYourSelf:
        {
          DesignDescriptionBottomSheet.show(
            Nav.globalContext,
            onContentedSaved: (content) {
              _openCreateDesignScreen(context, selectedImage, content);
            },
          );
        }
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    final cubit = context.read<HomeCubit>();
    cubit.refresh().then((_) {
      context.read<HomeCubit>().scrollToTop();
    });
  }

  void _openCreateDesignScreen(
      BuildContext context, File imageFile, String? description) {
    final cachedUserId = context.read<LoginInfoCubit>().user?.id ??
        Random().nextInt(1000000).toString();
    final projectId = DateTime.now().millisecondsSinceEpoch.toString() +
        cachedUserId.toString();
    if (description != null) {
      Nav.push(CreateDesignScreen(
          image: imageFile, description: description, projectId: projectId));
    } else {
      Nav.push(
          CreateDesignByYourSelfScreen(image: imageFile, projectId: projectId));
    }
  }
}
