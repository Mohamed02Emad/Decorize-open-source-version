import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/user/home/domain/enums/design_method.dart';
import 'package:flutter/material.dart';

class DesignMethodBottomSheet extends StatelessWidget {
  DesignMethodBottomSheet._({
    required this.onDesignMethodSelected,
  });

  final Function(DesignMethod designMethod) onDesignMethodSelected;
  final ValueNotifier<DesignMethod?> _selectedMethod = ValueNotifier(null);

  static show(BuildContext context,
      {required Function(DesignMethod designMethod) onDesignMethodSelected}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DesignMethodBottomSheet._(
            onDesignMethodSelected: onDesignMethodSelected);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.deviceHeight * 0.52,
      width: context.deviceWidth,
      child: Column(
        children: [
          12.gap,
          SvgPicture.asset(
            Assets.image.svg.createDesignPerson.path,
            width: context.deviceWidth * 0.45,
          ),
          12.gap,
          Text(
            context.tr(LocaleKeys.create_design_choose_design_method),
            style: TextStyles.semiBold16(),
          ),
          ValueListenableBuilder<DesignMethod?>(
            valueListenable: _selectedMethod,
            builder: (context, selectedMethod, child) {
              return Column(
                children: DesignMethod.values.map((method) {
                  return RadioListTile<DesignMethod>(
                    title: Text(
                      method.displayName,
                      style: selectedMethod == method
                          ? TextStyles.semiBold13()
                          : TextStyles.regular14(),
                    ),
                    value: method,
                    groupValue: selectedMethod,
                    onChanged: (DesignMethod? value) {
                      _selectedMethod.value = value;
                    },
                  );
                }).toList(),
              );
            },
          ),
          20.gap,
          ValueListenableBuilder(
            valueListenable: _selectedMethod,
            builder: (context, selectedMethod, child) => AppButton(
              enabled: selectedMethod != null,
              text: context.tr(LocaleKeys.action_next),
              onClick:
                  selectedMethod == null ? null : () => _onNextClicked(context),
              margin: 16.edgeInsetsHorizontal,
            ),
          ),
        ],
      ),
    );
  }

  void _onNextClicked(BuildContext context) {
    Nav.pop(context);
    onDesignMethodSelected(_selectedMethod.value!);
  }
}
