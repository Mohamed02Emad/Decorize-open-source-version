import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/util/navigation_helper.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/shared_features/auth/domain/params/reset_password_params.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/app_images.dart';
import '../../../../common/constant/app_svgs.dart';
import '../../../../common/constant/textStyles.dart';
import '../../../../common/constant/validator.dart';
import '../../../../common/di/injection_container.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/widget/app/app_button.dart';
import '../../../../common/widget/app/app_text_field.dart';
import '../../../../common/widget/spaces.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String token;

  const ResetPasswordScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ResetPasswordCubit>(),
      child: _ResetPasswordScreen(
        token: token,
      ),
    );
  }
}

class _ResetPasswordScreen extends StatefulWidget {
  const _ResetPasswordScreen({required this.token});

  final String token;

  @override
  State<_ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<_ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 123.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Hero(
                        tag: 'auth_logo',
                        child: Image.asset(
                          height: 64.h,
                          width: 66.7.w,
                          AppImages.appLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Height(8.h),
                    Center(
                      child: Text(
                        context.tr(LocaleKeys.auth_new_password),
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontFamily: TextStyles.arabicFontFamily,
                              fontSize: 24.sp,
                              color: context.appColors.text,
                            ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      context.tr(LocaleKeys.auth_password),
                      textAlign: TextAlign.right,
                      style: TextStyles.regular14Weight400(
                        context: context,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AppTextField(
                      prefixWidget: Padding(
                        padding: EdgeInsets.only(
                            left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
                        child: SvgPicture.asset(
                          height: 16.h,
                          width: 16.w,
                          AppSvgs.lock,
                          fit: BoxFit.contain,
                        ),
                      ),
                      hint: context.tr(LocaleKeys.auth_password).enterHint,
                      inputType: TextInputType.text,
                      validator: (value) => Validator.password(value),
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        Text(
                          context.tr(LocaleKeys.auth_confirm_password),
                          textAlign: TextAlign.right,
                          style: TextStyles.regular14Weight400(
                            context: context,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    AppTextField(
                      prefixWidget: Padding(
                        padding: EdgeInsets.only(
                            left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
                        child: SvgPicture.asset(
                          height: 16.h,
                          width: 16.w,
                          AppSvgs.lock,
                          fit: BoxFit.contain,
                        ),
                      ),
                      hint: context.tr(LocaleKeys.auth_password).enterHint,
                      inputType: TextInputType.text,
                      controller: _confirmPasswordController,
                      validator: (value) => Validator.confirmPassword(
                          value, _passwordController.text),
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Hero(
                      tag: 'change_pass',
                      child:
                          BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                        listener: (context, state) {
                          state.resetPasswordState.listen(
                            onSuccess: (data, message) {
                              showSuccessToast(LocaleKeys.action_success.tr());
                              _navigateUp();
                            },
                            onError: (message) => showErrorToast,
                          );
                        },
                        builder: (context, state) {
                          return AppButton(
                            fontSize: 14.sp,
                            isLoading: state.resetPasswordState.isLoading,
                            text: tr(LocaleKeys.action_send),
                            onClick: () {
                              _saveNewPassword(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _navigateUp() {
    popToFirst(context);
  }

  void _saveNewPassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final params = ResetPasswordParams(password: _passwordController.text);
      context.read<ResetPasswordCubit>().resetPassword(params);
    }
  }
}
