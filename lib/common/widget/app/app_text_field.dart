import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final String? initialValue, title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChange;
  final TextInputType inputType;
  final bool isPassword, readOnly, showCountryCode;
  final int? maxLines, minLines, length;
  final Function()? onTap, ignorePointerTap;
  final bool obscureText;
  final Widget? prefixWidget;
  final Widget? suffixIcon; // Added suffixIcon property
  final EdgeInsetsGeometry margin;

  const AppTextField({
    super.key,
    required this.hint,
    this.initialValue,
    required this.controller,
    this.validator,
    this.margin = EdgeInsets.zero,
    this.prefixWidget,
    this.suffixIcon, // Initialize suffixIcon
    this.readOnly = false,
    this.onChange,
    this.ignorePointerTap,
    this.title,
    this.maxLines,
    this.minLines,
    this.isPassword = false,
    this.obscureText = false,
    this.showCountryCode = false,
    this.length,
    this.inputType = TextInputType.text,
    this.onTap,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(
        Radius.circular(8.r),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: TextStyles.semiBold12(
                context: context, color: context.appColors.text),
          ).marginBottom(6.h),
        Padding(
          padding: widget.margin,
          child: TextFormField(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: widget.initialValue,
            controller: widget.controller,
            obscureText: widget.isPassword ? !_isPasswordVisible : false,
            validator: widget.validator,
            keyboardType: widget.inputType,
            maxLines: widget.isPassword && _isPasswordVisible.not()
                ? 1
                : widget.maxLines,
            minLines: widget.isPassword && _isPasswordVisible.not()
                ? 1
                : widget.minLines,
            readOnly: widget.readOnly,
            maxLength: widget.length,
            style: TextStyles.regular13(
              context: context,
            ),
            onChanged: (text) {
              if (widget.onChange != null) {
                widget.onChange!(text);
              }
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              filled: true,
              fillColor: context.appColors.onBackground,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.appColors.focusedBorder),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
              ),
              labelText: null,
              hintText: widget.hint,
              labelStyle: TextStyles.regular12Weight400(
                context: context,
                color: Colors.black45,
              ),
              hintStyle: TextStyles.regular11(
                context: context,
                color: context.appColors.hintText,
              ),
              alignLabelWithHint: false,
              prefixIcon: widget.prefixWidget,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return RotationTransition(
                              turns: animation, child: child);
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          key: ValueKey<bool>(_isPasswordVisible),
                          color: context.appColors.hintText,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : widget.suffixIcon,
              errorMaxLines: 2,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.appColors.shadowColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
              ),
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
            ),
          ),
        ).clickable(widget.ignorePointerTap , radius: 8.r),
      ],
    );
  }
}
