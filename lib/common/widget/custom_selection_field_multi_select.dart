import 'dart:async';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/gen/locale_keys.g.dart';
import 'app/app_text_field.dart';
import 'app/state_widgets/app_loading.dart';

class CustomSelectionFieldMultiSelect<T> extends StatefulWidget {
  const CustomSelectionFieldMultiSelect({
    super.key,
    this.title,
    this.hint,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.futureRequest,
    this.itemBuilder,
    this.itemToString,
    this.initialValues,
    this.isLoading = false,
  });

  final String? title;
  final String? hint;
  final String? prefixIcon;
  final void Function(List<T>? selectedItems)? onChanged;
  final String? Function(List<T>?)? validator;
  final FutureOr<List<T>> Function()? futureRequest;
  final Widget Function(BuildContext context, int index)? itemBuilder;
  final String Function(T? item)? itemToString;
  final List<T>? initialValues;
  final bool isLoading;

  static void show<T>({
    required BuildContext context,
    String? title,
    String? hint,
    String? prefixIcon,
    void Function(List<T>? selectedItems)? onChanged,
    String? Function(List<T>?)? validator,
    FutureOr<List<T>> Function()? futureRequest,
    Widget Function(BuildContext context, int index)? itemBuilder,
    String Function(T? item)? itemToString,
    List<T>? initialValues,
  }) {
    final ValueNotifier<List<T>> selectedValues =
        ValueNotifier<List<T>>(initialValues ?? []);

    showModalBottomSheet(
      context: context,
      builder: (context) => FutureBuilder<List<T>>(
        future: Future.value(futureRequest?.call()),
        builder: (context, snapshot) {
          final List<T> data = snapshot.data ?? [];
          Widget contentWidget;

          if (snapshot.connectionState == ConnectionState.waiting) {
            contentWidget = const AppLoading().withHeight(200);
          } else if (data.isEmpty) {
            contentWidget = Center(
              child: Text(
                tr.tr(LocaleKeys.error_error_no_results),
                style: TextStyles.regular12(),
              ).center().withHeight(200),
            );
          } else {
            // Success case: list and save button
            contentWidget = LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ValueListenableBuilder<List<T>>(
                          valueListenable: selectedValues,
                          builder: (context, selectedItems, child) {
                            return ListView.builder(
                              padding: 0.edgeInsetsAll,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                final isSelected = selectedItems.contains(item);

                                return IgnorePointer(
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: isSelected,
                                        onChanged: (checked) {}, // Ignored
                                      ),
                                      Text(itemToString?.call(item) ?? '',
                                          style: TextStyles.semiBold12()),
                                    ],
                                  ),
                                ).clickable(() {
                                  final checked = !isSelected;
                                  if (checked) {
                                    selectedValues.value = [
                                      ...selectedItems,
                                      item
                                    ];
                                  } else {
                                    selectedValues.value = selectedItems
                                        .where((e) => e != item)
                                        .toList();
                                  }
                                }, radius: 0).withBottomDivider();
                              },
                            );
                          },
                        ),
                      ),
                      AppButton(
                        onClick: () {
                          Nav.pop(context);
                          onChanged?.call(selectedValues.value);
                        },
                        text: tr.tr(LocaleKeys.action_save),
                      ).marginBottom(16).marginHorizontal(16),
                    ],
                  ),
                );
              },
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Text(
                    title,
                    style: TextStyles.semiBold16(),
                    textAlign: TextAlign.center,
                  ),
                ),
              Flexible(child: contentWidget),
            ],
          );
        },
      ),
    );
  }

  @override
  State<CustomSelectionFieldMultiSelect<T>> createState() =>
      _CustomSelectionFieldMultiSelectState<T>();
}

class _CustomSelectionFieldMultiSelectState<T>
    extends State<CustomSelectionFieldMultiSelect<T>> {
  late TextEditingController controller;
  late ValueNotifier<List<T>> _selectedValues;

  @override
  void initState() {
    _selectedValues = ValueNotifier<List<T>>(widget.initialValues ?? []);
    controller = TextEditingController(
      text: _selectedValues.value
          .map((e) => widget.itemToString?.call(e) ?? '')
          .join(', '),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      readOnly: true,
      hint: widget.hint ?? '',
      title: widget.title,
      controller: controller,
      validator: (_) => widget.validator?.call(_selectedValues.value),
      suffixIcon: widget.isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: const AppLoading(size: 16).scale(scaleValue: 2))
          : Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: context.appColors.text,
            ),
      onTap: () async {
        if (widget.isLoading) return;
        CustomSelectionFieldMultiSelect.show(
          context: context,
          title: widget.title,
          hint: widget.hint,
          prefixIcon: widget.prefixIcon,
          onChanged: (selected) {
            _selectedValues.value = selected ?? [];
            controller.text = _selectedValues.value
                .map((e) => widget.itemToString?.call(e) ?? '')
                .join(', ');
            widget.onChanged?.call(selected);
          },
          futureRequest: widget.futureRequest,
          itemToString: widget.itemToString,
          initialValues: _selectedValues.value,
        );
      },
    );
  }
}
