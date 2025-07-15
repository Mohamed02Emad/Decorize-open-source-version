import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/app_svgs.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/shared_features/auth/domain/enums/user_type.dart';
import 'package:decorizer/shared_features/auth/domain/models/responses/auth_response.dart';
import 'package:decorizer/shared_features/auth/domain/params/register_params.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:decorizer/shared_features/auth/presentation/pages/verify_screen.dart';
import 'package:decorizer/user/bottom_navigation/widgets/user_navigation_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/constant/app_images.dart';
import '../../../../common/constant/textStyles.dart';
import '../../../../common/constant/validator.dart';
import '../../../../common/di/injection_container.dart';
import '../../../../common/resources/gen/assets.gen.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../common/widget/app/AppCheckBox.dart';
import '../../../../common/widget/app/app_button.dart';
import '../../../../common/widget/app/app_text_field.dart';
import '../../../../common/widget/spaces.dart';
import '../../../static/domain/models/city_model.dart';
import '../../../static/domain/models/governorate_model.dart';
import '../../../static/domain/models/type_model.dart';
import '../cubit/login_info/login_info_cubit.dart';
import '../widgets/worker_register_drop_downs.dart';

class WorkerRegisterForm extends StatelessWidget {
  const WorkerRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return  _WorkerRegisterFormBody();
  }
}

class _WorkerRegisterFormBody extends StatefulWidget {
  const _WorkerRegisterFormBody();

  @override
  State<_WorkerRegisterFormBody> createState() =>
      _WorkerRegisterFormBodyState();
}

class _WorkerRegisterFormBodyState extends State<_WorkerRegisterFormBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ValueNotifier<TypeModel?> selectedJob = ValueNotifier(null);
  final ValueNotifier<GovernorateModel?> selectedGovernorate = ValueNotifier(null);
  final ValueNotifier<CityModel?> selectedCity = ValueNotifier(null);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool confirmPolicy = false;
  bool isTrainingCompany = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: context.viewPaddingTop,
                  left: 16.w,
                  right: 16.w,
                  bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const BackButton(),
                    ],
                  ),
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
                        context.tr(LocaleKeys.auth_create_account),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontFamily: TextStyles.arabicFontFamily,
                          fontSize: 18.sp,
                          color: context.appColors.text,
                        ),
                      ),
                    ),
                  ),
                  Height(16.h),
                  AppTextField(
                    title: context.tr(LocaleKeys.common_name),
                    validator: (value) => Validator.name(value),
                    hint: context.tr(LocaleKeys.common_name).enterHint,
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(
                          left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
                      child: SvgPicture.asset(
                        height: 16.h,
                        width: 16.w,
                        AppSvgs.outlinedProfile,
                        fit: BoxFit.contain,
                      ),
                    ),
                    inputType: TextInputType.text,
                    controller: _nameController,
                  ),
                  Height(12.h),
                  AppTextField(
                    title: context.tr(LocaleKeys.auth_email),
                    validator: (value) => Validator.email(value),
                    hint: context.tr(LocaleKeys.auth_email),
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
                  Height(12.h),
                  AppTextField(
                    title: context.tr(LocaleKeys.auth_phone_number),
                    validator: (value) => Validator.phone(value),
                    hint: context.tr(LocaleKeys.auth_phone_number).enterHint,
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(
                          left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
                      child: SvgPicture.asset(
                        height: 16.h,
                        width: 16.w,
                        AppSvgs.outlinedPhone,
                        fit: BoxFit.contain,
                      ),
                    ),
                    inputType: TextInputType.phone,
                    controller: _phoneController,
                  ),
                  Height(12.h),
                  AppTextField(
                    title: context.tr(LocaleKeys.auth_national_id),
                    validator: (value) => Validator.nationalId(value),
                    hint: context.tr(LocaleKeys.auth_national_id).enterHint,
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(
                          left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
                      child: Image.asset(
                        Assets.image.png.nationalId.path,
                        height: 16.h,
                        width: 16.w,
                        fit: BoxFit.contain,),
                    ),
                    inputType: TextInputType.number,
                    controller: _nationalIdController,
                  ),
                  Height(12.h),
                  WorkerRegisterDropDownsSection(
                    selectedJob: selectedJob,
                    selectedGovernorate: selectedGovernorate,
                    selectedCity: selectedCity,
                  ),
                  Height(12.h),
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
                  Height(12.h),
                  AppTextField(
                    title: context.tr(LocaleKeys.auth_confirm_password),
                    isPassword: true,
                    inputType: TextInputType.text,
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
                    validator: (value) => Validator.confirmPassword(
                        value, _passwordController.text),
                    hint: context.tr(LocaleKeys.auth_confirm_password).enterHint,
                    controller: _confirmPasswordController,
                  ),
                  Height(12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppCheckBox(
                        isChecked: confirmPolicy,
                        onClick: (b) {
                          setState(() {
                            confirmPolicy = !confirmPolicy;
                          });
                        },
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        context.tr(LocaleKeys.auth_i_accept),
                        textAlign: TextAlign.right,
                        style: TextStyles.regular12Weight400(
                          context: context,
                          color: context.appColors.hintText,
                        ),
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0.h),
                        child: Text(
                          context.tr(LocaleKeys.more_terms_and_conditions),
                          textAlign: TextAlign.right,
                          style: TextStyles.regular12Weight400(
                            context: context,
                            color: context.appColors.primary,
                          ),
                        ),
                      ).clickable(_termsClicked),
                    ],
                  ).clickable(() {
                    setState(() {
                      confirmPolicy = !confirmPolicy;
                    });
                  }),
                  Height(24.h),
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      state.registerState.listen(
                        onSuccess: (data, message) {
                          _onRegisterSuccess(data);
                        },
                        onError: (message) {
                          showErrorToast(message);
                        },
                      );
                    },
                    builder: (context, state) {
                      return Hero(
                        tag: 'reg_button',
                        child: AppButton(
                          fontSize: 14.sp,
                          isLoading: state.registerState.isLoading,
                          backgroundColor: confirmPolicy
                              ? context.appColors.primary
                              : context.appColors.hintText,
                          rippleColor: confirmPolicy
                              ? context.appColors.splashColor
                              : context.appColors.hintText,
                          text: context.tr(LocaleKeys.auth_create_account),
                          onClick: () {
                            if (confirmPolicy) _trySignup();
                          },
                        ),
                      );
                    },
                  ),
                  Height(12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.tr(LocaleKeys.auth_have_account),
                        style: TextStyles.regular14Weight400(
                            context: context, color: Colors.grey),
                      ),
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
                            context.tr(LocaleKeys.auth_login),
                            textAlign: TextAlign.right,
                            style: TextStyles.regular14Weight400(
                              context: context,
                              color: context.appColors.primary,
                            ),
                          ),
                        ),
                      ).clickable(_navigateToLogin),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }

  void _termsClicked() {}

  void _navigateToLogin() {
    Nav.pop(context);
  }

  void _navigateToHomeScreen() async {
    await sl<LoginInfoCubit>().init();
    //TODO replace with WorkerNavigationContainer when available
    Nav.pushReplacement(const UserNavigationContainer());
  }

  void _trySignup() async {
    if (formKey.currentState!.validate()) {
      final params = RegisterParams(
        name: _nameController.text,
        userType: UserType.worker,
        phone: _phoneController.text,
        typeId: selectedJob.value?.id.toString() ?? '',
        email: _emailController.text,
        password: _passwordController.text,
        governorateId: selectedGovernorate.value?.id.toString() ?? '',
        cityId: selectedCity.value?.id.toString() ?? '',
      );
      context.read<RegisterCubit>().register(params);
    }
  }

  void showVerificationBottomSheet() {
    VerifyScreen.show(
      context,
      onVerified: _cacheAndLogin,
      email: _emailController.text,
    );
  }

  void _onRegisterSuccess(AuthResponse data) {
    showVerificationBottomSheet();
  }

  void _cacheAndLogin(AuthResponse response) async {
    showSuccessToast(LocaleKeys.action_success);
    await context.read<RegisterCubit>().cacheUserData(response);
    _navigateToHomeScreen();
  }
}
