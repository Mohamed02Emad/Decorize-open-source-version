import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:flutter/material.dart';

class FormToBoxAdapter<T> extends FormField<T> {
  final double errorPaddingStart;
  final T? value;

  FormToBoxAdapter({
    super.key,
    required Widget child,
    required FormFieldValidator<T> super.validator,
    super.onSaved,
    super.initialValue,
    bool autovalidate = false,
    this.errorPaddingStart = 0,
    required this.value,
  }) : super(
          autovalidateMode: autovalidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<T> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child,
                if (field.hasError)
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 4.0,
                      start: errorPaddingStart,
                    ),
                    child: Text(
                      field.errorText!,
                      style: TextStyles.regular12(
                          context: field.context,
                          color: field.context.appColors.red),
                    ),
                  ),
              ],
            );
          },
        );

  @override
  FormToBoxAdapterState<T> createState() => FormToBoxAdapterState<T>();
}

class FormToBoxAdapterState<T> extends FormFieldState<T> {
  @override
  void didUpdateWidget(FormToBoxAdapter<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    super.validate();
  }
}
