import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/constant/validator.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/data_types/string.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/assets.gen.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignDescriptionBottomSheet extends StatefulWidget {
  const DesignDescriptionBottomSheet._({
    required this.onContentedSaved,
  });

  final Function(String content) onContentedSaved;

  static show(BuildContext context,
      {required Function(String content) onContentedSaved}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DesignDescriptionBottomSheet._(
            onContentedSaved: onContentedSaved,
          ),
        );
      },
    );
  }

  @override
  State<DesignDescriptionBottomSheet> createState() =>
      _DesignDescriptionBottomSheetState();
}

class _DesignDescriptionBottomSheetState
    extends State<DesignDescriptionBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.deviceHeight * 0.58,
      width: context.deviceWidth,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            12.gap,
            SvgPicture.asset(
              Assets.image.svg.createDesignPerson.path,
              width: context.deviceWidth * 0.45,
            ),
            12.gap,
            Text(
              context.tr(LocaleKeys.create_design_enter_design_description),
              style: TextStyles.semiBold16(),
            ),
            12.gap,
            AppTextField(
              hint: context
                  .tr(LocaleKeys.create_design_enter_design_description)
                  .enterHint,
              validator: Validator.emptyField,
              minLines: 5,
              maxLines: 7,
              controller: _contentController,
            ).marginHorizontal(16.w),
            20.gap,
            AppButton(
              text: context.tr(LocaleKeys.action_next),
              onClick: () => _onNextClicked(context),
              margin: 16.edgeInsetsHorizontal,
            )
          ],
        ),
      ),
    );
  }

  void _onNextClicked(BuildContext context) {
    final validData = _formKey.currentState?.validate() ?? false;
    if (validData.not()) return;
    Nav.pop(context);
    widget.onContentedSaved(_contentController.text);
  }
}
