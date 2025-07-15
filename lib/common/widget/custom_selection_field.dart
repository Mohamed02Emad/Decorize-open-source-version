import 'dart:async';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

import '../resources/gen/locale_keys.g.dart';
import 'app/app_text_field.dart';
import 'app/state_widgets/app_loading.dart';

class CustomSelectionField<T> extends StatefulWidget {
  const CustomSelectionField({
    super.key,
    this.title,
    this.hint,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.futureRequest,
    this.itemBuilder,
    this.itemToString,
    this.initialValue,
    this.titleStyle,
    this.isLoading = false,
  });

  final String? title;
  final String? hint;
  final String? prefixIcon;
  final void Function(T? selection)? onChanged;
  final String? Function(T? value)? validator;
  final FutureOr<List<T>> Function()? futureRequest;
  final Widget Function(BuildContext context, T? item)? itemBuilder;
  final String Function(T? item)? itemToString;
  final T? initialValue;
  final TextStyle? titleStyle;
  final bool isLoading;

  @override
  State<CustomSelectionField<T>> createState() =>
      _CustomSelectionFieldState<T>();
}

class _CustomSelectionFieldState<T> extends State<CustomSelectionField<T>> {
  late TextEditingController controller;
  late ValueNotifier<T?> _value;

  @override
  void initState() {
    _value = ValueNotifier<T?>(widget.initialValue);
    controller = TextEditingController(
        text: widget.itemToString?.call(widget.initialValue) ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      readOnly: true,
      hint: widget.hint ?? '',
      title: widget.title,
      controller: controller,
      prefixWidget: widget.prefixIcon != null
          ? Icon(Icons.get_app) // Replace with actual widget for prefixIcon
          : null,
      validator: (_) => widget.validator?.call(_value.value),
      suffixIcon: widget.isLoading
          ?  SizedBox(
              width: 24,
              height: 24,
              child: const AppLoading(size: 16).scale(scaleValue: 2))

          : Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: context.appColors.text,
            ),
      onTap: () async {
        showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Text(
                  widget.title ?? widget.hint ?? '',
                  style:
                      widget.titleStyle ?? TextStyles.bold14(context: context),
                ),
              ),
              8.gap,
              Flexible(
                child: SizedBox(
                  height: 400.h,
                  child: FutureBuilder<List<T>>(
                    future: Future.value(widget.futureRequest?.call()),
                    builder: (context, snapshot) {
                      final List<T> data = snapshot.data ?? [];
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const AppLoading().withHeight(200);
                      }
                      if (data.isEmpty) {
                        return Center(
                          child: Text(
                            LocaleKeys.error_error_no_results.tr(),
                            style: TextStyles.semiBold14(),
                          ).center().withHeight(200),
                        );
                      }
                      return ListView.builder(
                        padding: 0.edgeInsetsAll,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return Row(
                            children: [
                              widget.itemBuilder == null
                                  ? Text(
                                      widget.itemToString?.call(item) ?? '',
                                      style:
                                          TextStyles.bold13(context: context),
                                    ).paddingAll(5)
                                  : widget.itemBuilder!(context, item),
                              const Spacer(),
                              if (_value.value == item)
                                Icon(
                                  Icons.check,
                                  size: 16,
                                  color: context.appColors.primary,
                                )
                            ],
                          )
                              .marginSymmetric(horizontal: 16.w, vertical: 6.h)
                              .clickable(() {
                            if (item.runtimeType == T)
                              widget.onChanged?.call(item);
                            _value.value = item;
                            controller.text =
                                widget.itemToString?.call(item) ?? '';
                            Nav.pop(context);
                          }, radius: 0).withBottomDivider();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
