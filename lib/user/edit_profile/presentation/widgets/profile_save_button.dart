import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/user/edit_profile/presentation/cubits/update_profile/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSaveButton extends StatelessWidget {
  const ProfileSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state.updateProfileState.isSuccess) {
          showSuccessToast(
              context.tr(LocaleKeys.edit_profile_profile_updated_successfully));
          final user = state.updateProfileState.data;
          if (user != null) {
            context.read<LoginInfoCubit>().updateUser(user);
          }
          // Update cached user through the repository
          Nav.pop(context);
        } else if (state.updateProfileState.isError) {
          showErrorToast(state.updateProfileState.message ??
              context.tr(LocaleKeys.edit_profile_an_error_occurred));
        }
      },
      builder: (context, state) {
        // Only show save button if there are changes
        if (!state.hasChanges) {
          return const SizedBox.shrink();
        }

        return AppButton(
          isLoading: state.updateProfileState.isLoading,
          text: context.tr(LocaleKeys.action_save),
          onClick: state.updateProfileState.isLoading
              ? null
              : () => context.read<UpdateProfileCubit>().saveProfile(),
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h)
              .copyWith(bottom: 8.h),
        );
      },
    );
  }
}
