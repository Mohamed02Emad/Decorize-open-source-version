import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/system_bars_util.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/shared_features/auth/domain/enums/user_type.dart';
import 'package:decorizer/shared_features/auth/domain/models/responses/auth_response.dart';
import 'package:decorizer/shared_features/auth/domain/params/login_params.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/shared_features/auth/presentation/pages/user_register_screen.dart';
import 'package:decorizer/shared_features/auth/presentation/pages/verify_screen.dart';
import 'package:decorizer/shared_features/auth/presentation/pages/worker_register_screen.dart';
import 'package:decorizer/user/bottom_navigation/widgets/user_navigation_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/app_images.dart';
import '../../../../common/constant/textStyles.dart';
import '../../../../common/constant/validator.dart';
import '../../../../common/di/injection_container.dart';
import '../../../../common/resources/gen/assets.gen.dart';
import '../../../../common/util/device_and_app_info_util.dart';
import '../../../../common/widget/app/app_button.dart';
import '../../../../common/widget/app/app_text_field.dart';
import '../../../../common/widget/dialogs/language_dialog.dart';
import '../../../../common/widget/spaces.dart';
import '../../../../worker/bottom_navigation/widgets/worker_navigation_container.dart';
import '../../../setup_screens/presentation/pages/user_type_screen.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  final UserType userType;
  const LoginScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: _LoginScreenBody(userType),
    );
  }
}

class _LoginScreenBody extends StatefulWidget {
  const _LoginScreenBody(this.userType);
  final UserType userType;

  @override
  State<_LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    SystemBarsUtil.changeStatusAndNavigationBars(
      navBarColor: context.appColors.onBackground,
      statusBarColor: context.appColors.transparent,
      isBlackIcons: context.isDarkMode ? false : true,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    onPressed: _openSelectUserTypeScreen,
                  ),
                  SvgPicture.asset(
                    AppSvgs.language,
                    width: 23.w,
                    colorFilter: context.isDarkMode ? context.appColors.text.colorFilter : null,
                  )
                      .marginAll(4.w)
                      .clickable(_showLanguageDialog)
                      .marginEnd(10.w)
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.only(
                      top: 10.h, right: 20.w, left: 20.w, bottom: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Hero(
                          tag: 'auth_logo',
                          child: SvgPicture.asset(
                            Assets.image.svg.logoWhite.path,
                            height: 110.h,
                            colorFilter: context.isDarkMode ? context.appColors.text.colorFilter : context.appColors.primary.colorFilter,
                            fit: BoxFit.contain,
                          ).clickable(
                            () {
                              _emailController.text = 'test@gmail.com';
                              _passwordController.text = 'Tt123456';
                            },
                          ),
                        ),
                      ),
                      Height(8.h),
                      Hero(
                        tag: 'auth_title',
                        child: Text(
                          context.tr(LocaleKeys.auth_login),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontFamily: TextStyles.arabicFontFamily,
                                fontSize: 20.sp,
                                color: context.appColors.text,
                              ),
                        ),
                      ),
                      16.gap,
                      AppTextField(
                        title: context.tr(LocaleKeys.auth_email),
                        validator: (value) => Validator.email(value),
                        hint: context.tr(LocaleKeys.auth_email).enterHint,
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
                        inputType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      10.gap,
                      AppTextField(
                        title: context.tr(LocaleKeys.auth_password),
                        validator: (value) => Validator.password(value),
                        isPassword: true,
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
                        inputType: TextInputType.text,
                        hint: context.tr(LocaleKeys.auth_password).enterHint,
                        controller: _passwordController,
                      ),
                      Height(6.h),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(
                              bottom: 5.h,
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.4.w,
                            ))),
                            child: Text(
                              context.tr(LocaleKeys.auth_forgot_password),
                              style: TextStyles.regular12(
                                  context: context, color: Colors.grey),
                            ),
                          ).clickable(_navigateToForgetPassword)
                        ],
                      ),
                      Height(
                        24.h,
                      ),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          state.loginState.listen(
                            onSuccess: (data, message) {
                              if (data.verificationCode == null) {
                                showSuccessToast(LocaleKeys.action_success);
                                _navigateToHomeScreen();
                              } else {
                                _showVerifyBottomSheet(data);
                              }
                            },
                            onError: showErrorToast,
                          );
                        },
                        builder: (context, state) {
                          return Hero(
                            tag: "reg_button",
                            child: AppButton(
                              fontSize: 14.sp,
                              isLoading: state.loginState.isLoading,
                              text: tr(LocaleKeys.auth_login),
                              onClick: _tryLogin,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      if (widget.userType.isClient)
                        AppButton(
                          fontSize: 14.sp,
                          height: 35.h,
                          isLoading: false,
                          borderColor: context.appColors.primary,
                          isBordered: true,
                          backgroundColor: context.appColors.background,
                          text: tr(LocaleKeys.auth_login_guest),
                          onClick: () {
                            _loginAsGuestClicked();
                          },
                        ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            context.tr(LocaleKeys.auth_no_account),
                            style: TextStyles.regular14Weight400(
                                context: context, color: Colors.grey),
                          ).fittedBox(fit: BoxFit.contain),
                          SizedBox(
                            width: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.h),
                            child: Container(
                              padding: EdgeInsets.only(
                                bottom: 5.h,
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: context.appColors.primary,
                                width: 1.4.w,
                              ))),
                              child: Text(
                                  context.tr(LocaleKeys.auth_create_account),
                                  textAlign: TextAlign.right,
                                  style: TextStyles.regular14(
                                    context: context,
                                    color: context.appColors.primary,
                                  )).fittedBox(fit: BoxFit.contain),
                            ),
                          ).clickable(_navigateToSignUp),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          sl<DeviceAndAppInfoUtil>().appVersion,
                          style: TextStyles.semiBold12(
                              color: context.appColors.primary),
                        ).marginTop(20),
                      ),
                    ],
                  ),
                )),
              ),
            ],
          )),
    ));
  }

  void _navigateToSignUp() {
    if (widget.userType == UserType.user) {
      Nav.push(const UserRegisterScreen());
    } else {
      Nav.push(const WorkerRegisterScreen());
    }
  }

  void _navigateToForgetPassword() {
    if (widget.userType == UserType.user) {
      Nav.push(const ForgetPasswordScreen());
    }
    else {

    }
  }

  void _navigateToHomeScreen() async {
    await sl<LoginInfoCubit>().init();
    if (widget.userType == UserType.user) {
      Nav.pushReplacement(const UserNavigationContainer());
    } else {
      Nav.pushReplacement(const WorkerNavigationContainer());
    }
  }

  void _tryLogin() async {
    if (formKey.currentState!.validate()) {
      //todo: handle different endpoint
      final params = LoginParams(
          email: _emailController.text, password: _passwordController.text);
      context.read<LoginCubit>().login(params);
    }
  }

  void _loginAsGuestClicked() {
    _navigateToHomeScreen();
  }

  void _showLanguageDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const LanguageDialog();
        });
  }

  void _openSelectUserTypeScreen() {
    Nav.pushReplacement(const UserTypeScreen());
  }

  void _showVerifyBottomSheet(AuthResponse data) {
    VerifyScreen.show(
      context,
      email: data.user.email,
      onVerified: (response) async {
        showSuccessToast(LocaleKeys.action_success);
        await context.read<LoginCubit>().cacheUserData(response);
        _navigateToHomeScreen();
      },
    );
  }
}
