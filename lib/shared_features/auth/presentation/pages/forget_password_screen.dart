import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/shared_features/auth/domain/params/forget_password_params.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:decorizer/shared_features/auth/presentation/pages/reset_password_screen.dart';
import 'package:decorizer/shared_features/auth/presentation/pages/verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/app_images.dart';
import '../../../../common/constant/textStyles.dart';
import '../../../../common/constant/validator.dart';
import '../../../../common/di/injection_container.dart';
import '../../../../common/util/ui_helper.dart';
import '../../../../common/widget/app/app_button.dart';
import '../../../../common/widget/app/app_text_field.dart';
import '../../../../common/widget/spaces.dart';
import '../../domain/models/responses/auth_response.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgetPasswordCubit>(),
      child: const _ForgetPasswordBody(),
    );
  }
}

class _ForgetPasswordBody extends StatefulWidget {
  const _ForgetPasswordBody();

  @override
  State<_ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<_ForgetPasswordBody> {
  final _emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // TODO fix app bar
        appBar: AppBar(),
        body: SafeArea(
            child: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(
                top: 167.5.h, right: 20.w, left: 20.w, bottom: 369.5.h),
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
                  child: Hero(
                    tag: 'auth_title',
                    child: Text(
                      context.tr(LocaleKeys.auth_forgot_password),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontFamily: TextStyles.arabicFontFamily,
                            fontSize: 24.sp,
                            color: context.appColors.text,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  context.tr(LocaleKeys.auth_email),
                  textAlign: TextAlign.right,
                  style: TextStyles.regular14Weight400(
                    context: context,
                  ),
                ),
                SizedBox(height: 8.h),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (context, state) {
                    return AppTextField(
                      prefixWidget: Padding(
                        padding: EdgeInsets.only(
                            left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
                        child: SvgPicture.asset(
                          height: 16.h,
                          width: 16.w,
                          Assets.image.svg.emailOutlined.path,
                          fit: BoxFit.contain,
                        ),
                      ),
                      hint: context.tr(LocaleKeys.auth_email).enterHint,
                      inputType: TextInputType.emailAddress,
                      validator: (value) => Validator.email(value),
                      controller: _emailController,
                    ).disableClicks(state.forgetPasswordState.isLoading);
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                  listener: (context, state) {
                    state.forgetPasswordState.listen(
                      onSuccess: (data, message) {
                        showVerificationBottomSheet();
                      },
                      onError: (message) => showErrorToast,
                    );
                  },
                  builder: (context, state) {
                    return AppButton(
                      fontSize: 14.sp,
                      isLoading: state.forgetPasswordState.isLoading,
                      text: context.tr(LocaleKeys.action_send),
                      onClick: () {
                        _sendCodeClicked();
                      },
                    );
                  },
                )
              ],
            ),
          )),
        )));
  }

  void _sendCodeClicked() {
    if (formKey.currentState!.validate()) {
      final params = ForgetPasswordParams(
        email: _emailController.text,
      );
      context.read<ForgetPasswordCubit>().forgetPassword(params);
    }
  }

  void showVerificationBottomSheet() {
    VerifyScreen.show(
      context,
      onVerified: _openResetPasswordScreen,
      email: _emailController.text,
    );
  }

  void _openResetPasswordScreen(AuthResponse response) {
    Nav.pushReplacement(ResetPasswordScreen(token : response.accessToken));
  }
}
