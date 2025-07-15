import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/theme/color/app_colors.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/common/widget/dialogs/action_dialog.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/shared_features/more/data/datasource/more_datasource.dart';
import 'package:decorizer/shared_features/more/presentation/cubits/more/more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/di/injection_container.dart';
import '../../../../../common/resources/gen/assets.gen.dart';
import '../../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../../common/util/guest_util.dart';
import '../../../../../common/util/navigation_helper.dart';
import '../../../../../common/widget/app/floating_card.dart';
import '../../../../auth/domain/enums/user_type.dart';
import '../../../../auth/presentation/pages/login_screen.dart';
import '../logout_dialog.dart';
import '../more_item.dart';

class ActionsSection extends StatelessWidget {
  const ActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      shadowColor: context.appColors.shadowColor,
      child: Column(
        children: [
          BlocConsumer<MoreCubit, MoreState>(
            buildWhen: (previous, current) =>
                previous.logoutState != current.logoutState,
            listenWhen: (previous, current) =>
                previous.logoutState != current.logoutState,
            listener: (context, state) => state.logoutState.listen(
              onSuccess: (_, __) {
                showSuccessToast(context.tr(LocaleKeys.action_success));
                _loggedOutSuccessfully(context);
              },
              onError: showErrorToast,
            ),
            builder: (context, state) => MoreItem(
              svgAsset: Assets.image.svg.logout.path,
              isLoading: state.logoutState.isLoading,
              title: GuestUtil.isGuest
                  ? context.tr(LocaleKeys.auth_login)
                  : context.tr(LocaleKeys.more_logout),
              onClick: () => _logOutClicked(context),
            ),
          ),
          Divider(height: 6.h),
          BlocConsumer<MoreCubit, MoreState>(
            buildWhen: (previous, current) =>
                previous.deleteAccountState != current.deleteAccountState,
            listenWhen: (previous, current) =>
                previous.deleteAccountState != current.deleteAccountState,
            listener: (context, state) => state.deleteAccountState.listen(
              onSuccess: (data, message) {
                showSuccessToast(
                    context.tr(LocaleKeys.more_deleteAccountSuccess));
                _loggedOutSuccessfully(context);
              },
              onError: showErrorToast,
            ),
            builder: (context, state) => MoreItem(
              isLoading: state.deleteAccountState.isLoading,
              svgAsset: Assets.image.svg.deleteAccount.path,
              title: context.tr(LocaleKeys.more_delete_account),
              color: AppColors.red,
              onClick: () => _deleteAccountClicked(context),
            ),
          ),
        ],
      ),
    );
  }

  void _logOutClicked(BuildContext context) async {
    final isGuest = GuestUtil.isGuest;
    if (isGuest.not()) {
      LogOutDialog.show(context, () {
        context.read<MoreCubit>().logout();
      });
    } else {
      _loggedOutSuccessfully(context);
    }
  }

  void _loggedOutSuccessfully(BuildContext context) async {
    await sl<LoginInfoCubit>().init();
    await popToFirst(context);
    Nav.pushReplacement(LoginScreen(
      userType: context.currentUserType ?? UserType.user,
    ));
  }

  void _deleteAccountClicked(BuildContext context) async {
    ActionDialog.showDeleteDialog(
      context,
      title: context.tr(LocaleKeys.more_delete_account),
      onPositiveClicked: () {
        context.read<MoreCubit>().deleteAccount();
      },
    );
  }
}
