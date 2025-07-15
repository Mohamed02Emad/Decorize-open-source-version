import 'package:decorizer/common/extentions/context_extension.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/shared_features/auth/domain/models/responses/auth_response.dart';
import 'package:decorizer/shared_features/auth/domain/params/verify_otp_params.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/verify_otp/verify_otp_cubit.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav/nav.dart';

import '../../../../common/constant/app_images.dart';
import '../../../../common/constant/textStyles.dart';
import '../../../../common/di/injection_container.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/widget/app/app_button.dart';
import '../../../../common/widget/spaces.dart';

class VerifyScreen extends StatelessWidget {
  final Function(AuthResponse response) onVerified;
  final String? email;

  const VerifyScreen._({required this.onVerified, required this.email});

  static void show(
    BuildContext context, {
    String? email,
    required Function(AuthResponse response) onVerified,
  }) async {
    await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        elevation: 20,
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: 12.borderRadius,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: VerifyScreen._(
                onVerified: onVerified,
                email: email,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<VerifyOtpCubit>(),
      child: _VerifyScreenBody(
        onVerified: onVerified,
        email: email,
      ),
    );
  }
}

class _VerifyScreenBody extends StatefulWidget {
  final String? email;
  final Function(AuthResponse response) onVerified;

  const _VerifyScreenBody({required this.onVerified, this.email});

  @override
  State<_VerifyScreenBody> createState() => _VerifyScreenBodyState();
}

class _VerifyScreenBodyState extends State<_VerifyScreenBody> {
  final TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
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
                '${context.tr(LocaleKeys.auth_enter_code_sent_to_number)} ${widget.email}',
                textAlign: TextAlign.right,
                style: TextStyles.semiBold14(context: context),
              ),
            ),
            SizedBox(height: 32.h),
            BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
              builder: (context, state) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: OtpTextField(
                    numberOfFields: 4,
                    fieldWidth: 56.w,
                    fieldHeight: 56.w,
                    focusedBorderColor: context.appColors.primary,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    borderColor: context.appColors.hintText,
                    showFieldAsBox: true,
                    onSubmit: (String verificationCode) {
                      mprint('Full code: $verificationCode');
                      codeController.text = verificationCode;
                    },
                    onCodeChanged: (String code) {
                      if (codeController.text.length == 4) {
                        codeController.text = '';
                      }
                    },
                  ).disableClicks(state.verifyState.isLoading),
                );
              },
            ),
            Height(24.h),
            BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
              listener: (context, state) {
                state.verifyState.listen(
                  onSuccess: (data, message) {
                    Nav.pop(context);
                    _onSuccess(data);
                  },
                  onError: showErrorToast,
                );
              },
              builder: (context, state) {
                return AppButton(
                  fontSize: 14.sp,
                  isLoading: state.verifyState.isLoading,
                  text: tr.tr(LocaleKeys.action_send),
                  onClick: () {
                    _sendCode();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _sendCode() {
    if (codeController.text.length < 4) {
      showErrorToast(LocaleKeys.error_all_fields_are_required);
      return;
    }
    final params =
        VerifyOtpParams(code: codeController.text, email: widget.email);
    context.read<VerifyOtpCubit>().verifyOtp(params);
  }

  void _onSuccess(AuthResponse response) {
    widget.onVerified(response);
  }
}
