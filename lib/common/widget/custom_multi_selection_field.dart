import 'dart:async';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/text_style_extensions.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/gen/locale_keys.g.dart';
import 'app/app_text_field.dart';
import 'app/state_widgets/app_loading.dart';
import 'custom_selection_field_multi_select.dart';


class CustomMultiSelectField<T> extends StatefulWidget {
  const CustomMultiSelectField({
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
  });

  final String? title;
  final String? hint;
  final String? prefixIcon;
  final void Function(List<T>?)? onChanged;
  final String? Function(List<T>?)? validator;
  final FutureOr<List<T>> Function()? futureRequest;
  final Widget Function(BuildContext, int)? itemBuilder;
  final String Function(T?)? itemToString;
  final List<T>? initialValues;

  static void show<T>({
    required BuildContext context,
    String? title,
    String? hint,
    String? prefixIcon,
    void Function(List<T>? items)? onChanged,
    String? Function(List<T>?)? validator,
    FutureOr<List<T>> Function()? futureRequest,
    Widget Function(BuildContext, int)? itemBuilder,
    String Function(T?)? itemToString,
    List<T>? initialValues,
  }) {
    final ValueNotifier<List<T>> selectedValues = ValueNotifier<List<T>>(initialValues ?? []);

    showModalBottomSheet(
      context: context,
      //title: Text(hint ?? title ?? '', style: context.bodyLarge.bold),
      builder:(context) =>  FutureBuilder<List<T>>(
        future: Future.value(futureRequest?.call()),
        builder: (context, snapshot) {
          final List<T> data = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
          }
          if (data.isEmpty) {
            return Center(
              child: Text(
                tr.tr(LocaleKeys.error_error_no_results),
                style:TextStyles.regular12(),
              ).center().withHeight(200),
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 500,
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
                                onChanged: (checked) {
                                  if (checked == true) {
                                    selectedValues.value = [...selectedItems, item];
                                  } else {
                                    selectedValues.value = selectedItems.where((e) => e != item).toList();
                                  }
                                  selectedValues.notifyListeners(); // Ensure the UI updates
                                },
                              ),
                              Text(itemToString?.call(item) ?? '', style: TextStyles.bold12()),
                            ],
                          ).paddingSymmetric(horizontal: 16, vertical: 8),
                        ).clickable(() {
                          final checked = !isSelected;
                          if (checked == true) {
                            selectedValues.value = [...selectedItems, item];
                          } else {
                            selectedValues.value = selectedItems.where((e) => e != item).toList();
                          }
                          selectedValues.notifyListeners();
                        });
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Nav.pop(context);
                  onChanged?.call(selectedValues.value);
                },
                child: Text(
                  tr.tr(LocaleKeys.action_save),
                  style: context.textTheme.bodySmall?.s16.setColor(Colors.black),
                ),
              ).marginBottom(16).marginHorizontal(16),
            ],
          );
        },
      ),
    );
  }

  @override
  State<CustomMultiSelectField<T>> createState() => _CustomMultiSelectFieldState<T>();
}

class _CustomMultiSelectFieldState<T> extends State<CustomMultiSelectField<T>> {
  late TextEditingController controller;
  late ValueNotifier<List<T>> _selectedValues;

  @override
  void initState() {
    _selectedValues = ValueNotifier<List<T>>(widget.initialValues ?? []);
    controller = TextEditingController(
      text: _selectedValues.value.map((e) => widget.itemToString?.call(e) ?? '').join(', '),
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
      prefixWidget: widget.prefixIcon != null
          ? Icon(Icons.get_app) // Replace with actual widget for prefixIcon
          : null,
      validator: (_) => widget.validator?.call(_selectedValues.value),
      margin: EdgeInsets.only(top: 10), // Adjusted margin
      suffixIcon: Icon(
        Icons.arrow_drop_down,
        size: 16,
        color: context.appColors.text,
      ),
      onTap: () async {
        CustomSelectionFieldMultiSelect.show(
          context: context,
          title: widget.title,
          hint: widget.hint,
          prefixIcon: widget.prefixIcon,
          onChanged: (selected) {
            _selectedValues.value = selected ?? [];
            controller.text = _selectedValues.value.map((e) => widget.itemToString?.call(e) ?? '').join(', ');
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
