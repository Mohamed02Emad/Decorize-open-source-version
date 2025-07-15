import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:flutter/material.dart';

class CheckRow extends StatelessWidget {
  final bool isChecked;
  final String title;
  final Function(bool) onCheckChange;

  const CheckRow(
      {super.key,
      required this.isChecked,
      required this.onCheckChange,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCheckChange(isChecked.not());
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: null,
            checkColor: context.appColors.white,
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (!states.contains(MaterialState.selected)) {
                return null;
              }
              return context.appColors.primary;
            }),
          ),
          Text(
            title,
            style: TextStyles.regular14(),
          ),
        ],
      ),
    );
  }
}
