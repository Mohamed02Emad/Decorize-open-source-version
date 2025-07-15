import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/system_bars_util.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_text_field.dart';
import 'package:decorizer/user/edit_profile/presentation/cubits/change_password/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set system bars color
    SystemBarsUtil.changeNavigationBar(context.appColors.background);

    return BlocProvider(
      create: (context) => sl<ChangePasswordCubit>(),
      child: Scaffold(
        appBar: AppTitleBar(
          title: context.tr(LocaleKeys.edit_profile_change_password),
          hasBackButton: true,
        ),
        backgroundColor: context.appColors.background,
        body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Old Password Field
                  AppTextField(
                    controller: oldPasswordController,
                    hint: context.tr(LocaleKeys.edit_profile_old_password),
                    isPassword: true,
                    onChange: (value) {
                      context
                          .read<ChangePasswordCubit>()
                          .updateOldPassword(value ?? '');
                    },
                  ),
                  const SizedBox(height: 16),

                  // New Password Field
                  AppTextField(
                    controller: newPasswordController,
                    hint: context.tr(LocaleKeys.edit_profile_new_password),
                    isPassword: true,
                    onChange: (value) {
                      context
                          .read<ChangePasswordCubit>()
                          .updateNewPassword(value ?? '');
                    },
                  ),
                  if (state.passwordError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        state.passwordError!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Confirm Password Field
                  AppTextField(
                    controller: confirmPasswordController,
                    hint: context.tr(LocaleKeys.edit_profile_confirm_password),
                    isPassword: true,
                    onChange: (value) {
                      context
                          .read<ChangePasswordCubit>()
                          .updateConfirmPassword(value ?? '');
                    },
                  ),
                  if (state.confirmPasswordError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        state.confirmPasswordError!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 32),

                  // Submit Button
                  BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                    listener: (context, state) {
                      if (state.changePasswordState.isSuccess) {
                        showSuccessToast(context.tr(LocaleKeys
                            .edit_profile_password_changed_successfully));
                        // Clear the form
                        oldPasswordController.clear();
                        newPasswordController.clear();
                        confirmPasswordController.clear();
                        // Navigate back
                        Nav.pop(context);
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        text:
                            context.tr(LocaleKeys.edit_profile_change_password),
                        isLoading: state.changePasswordState.isLoading,
                        enabled: state.isFormValid,
                        onClick: () {
                          context.read<ChangePasswordCubit>().changePassword();
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
