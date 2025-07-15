import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/constant/validator.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileFormFields extends StatefulWidget {
  final dynamic user;
  final String name;
  final String email;
  final String phone;
  final String password;
  final Function(String) onNameChanged;
  final Function(String) onEmailChanged;
  final Function(String) onPhoneChanged;
  final Function(String) onPasswordChanged;
  final VoidCallback onChangePasswordClicked;

  const ProfileFormFields({
    super.key,
    required this.user,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPhoneChanged,
    required this.onPasswordChanged,
    required this.onChangePasswordClicked,
  });

  @override
  State<ProfileFormFields> createState() => _ProfileFormFieldsState();
}

class _ProfileFormFieldsState extends State<ProfileFormFields> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _passwordController = TextEditingController(text: widget.password);
  }

  @override
  void didUpdateWidget(ProfileFormFields oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update controllers when widget props change
    if (oldWidget.name != widget.name) {
      _nameController.text = widget.name;
    }
    if (oldWidget.email != widget.email) {
      _emailController.text = widget.email;
    }
    if (oldWidget.phone != widget.phone) {
      _phoneController.text = widget.phone;
    }
    if (oldWidget.password != widget.password) {
      _passwordController.text = widget.password;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.user.name, style: TextStyles.semiBold14()),
        _buildNameField(context),
        10.gap,
        _buildEmailField(context),
        10.gap,
        _buildPhoneField(context),
        10.gap,
        _buildPasswordField(context),
        30.gap,
      ],
    );
  }

  Widget _buildNameField(BuildContext context) {
    return AppTextField(
      title: context.tr(LocaleKeys.auth_full_name),
      validator: Validator.name,
      hint: context.tr(LocaleKeys.auth_full_name).enterHint,
      prefixWidget: Padding(
        padding:
            EdgeInsets.only(left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
        child: SvgPicture.asset(
          height: 16.h,
          width: 16.w,
          Assets.image.svg.profile2.path,
          fit: BoxFit.contain,
        ),
      ),
      inputType: TextInputType.text,
      onChange: (value) => widget.onNameChanged(value ?? ''),
      controller: _nameController,
    ).marginHorizontal(16.w);
  }

  Widget _buildEmailField(BuildContext context) {
    return AppTextField(
      title: context.tr(LocaleKeys.auth_email),
      validator: (value) => Validator.email(value),
      hint: context.tr(LocaleKeys.auth_email).enterHint,
      prefixWidget: Padding(
        padding:
            EdgeInsets.only(left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
        child: SvgPicture.asset(
          height: 16.h,
          width: 16.w,
          Assets.image.svg.emailOutlined.path,
          fit: BoxFit.contain,
        ),
      ),
      inputType: TextInputType.emailAddress,
      onChange: (value) => widget.onEmailChanged(value ?? ''),
      controller: _emailController,
    ).marginHorizontal(16.w);
  }

  Widget _buildPhoneField(BuildContext context) {
    return AppTextField(
      title: context.tr(LocaleKeys.auth_phone),
      validator: Validator.phone,
      hint: context.tr(LocaleKeys.auth_phone).enterHint,
      prefixWidget: Padding(
        padding:
            EdgeInsets.only(left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
        child: SvgPicture.asset(
          height: 16.h,
          width: 16.w,
          Assets.image.svg.outlinedPhone.path,
          fit: BoxFit.contain,
        ),
      ),
      inputType: TextInputType.phone,
      onChange: (value) => widget.onPhoneChanged(value ?? ''),
      controller: _phoneController,
    ).marginHorizontal(16.w);
  }

  Widget _buildPasswordField(BuildContext context) {
    return AppTextField(
      title: context.tr(LocaleKeys.auth_password),
      validator: (value) => Validator.password(value),
      hint: context.tr(LocaleKeys.auth_password).enterHint,
      prefixWidget: Padding(
        padding:
            EdgeInsets.only(left: 4.w, right: 8.w, top: 16.h, bottom: 16.h),
        child: SvgPicture.asset(
          height: 16.h,
          width: 16.w,
          Assets.image.svg.lock.path,
          fit: BoxFit.contain,
        ),
      ),
      inputType: TextInputType.text,
      ignorePointerTap: widget.onChangePasswordClicked,
      onChange: (value) => widget.onPasswordChanged(value ?? ''),
      controller: _passwordController,
    ).marginHorizontal(16.w);
  }
}
