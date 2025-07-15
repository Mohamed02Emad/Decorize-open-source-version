import 'package:decorizer/common/constant/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChange;
  final TextInputType? inputType;
  final Function()? onTap;
  final EdgeInsetsGeometry margin;
  final bool isPassword, isReadOnly, showCountryCode;
  final bool isChoiceField;

  const DataTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.onChange,
    this.inputType,
    this.margin = EdgeInsets.zero,
    this.isPassword = false,
    this.isReadOnly = false,
    this.showCountryCode = false,
    this.onTap,
    required this.isChoiceField,
  });

  @override
  State<StatefulWidget> createState() => _DataTextFieldState();
}

class _DataTextFieldState extends State<DataTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            textAlign: TextAlign.start,
            style: TextStyles.regular15(),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            autovalidateMode: AutovalidateMode.disabled,
            controller: widget.controller,
            keyboardType: widget.inputType,
            validator: widget.validator,
            readOnly: widget.isReadOnly,
            obscureText: widget.isPassword,
            onChanged: (text) {
              if (widget.onChange != null) {
                widget.onChange!(text);
              }
            },
            decoration: InputDecoration(
              suffixIcon: widget.isChoiceField
                  ? const Column(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_up_sharp,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                        ),
                      ],
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
