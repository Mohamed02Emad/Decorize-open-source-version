import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/widget/data_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SectionDialog extends StatefulWidget {
  final Function(String) onSectionAdded;

  const SectionDialog._({required this.onSectionAdded});

  static void show(BuildContext context, Function(String) onSectionAdded) {
    showDialog(
      context: context,
      builder: (context) => SectionDialog._(onSectionAdded: onSectionAdded),
    );
  }

  @override
  State<SectionDialog> createState() => _SectionDialogState();
}

class _SectionDialogState extends State<SectionDialog> {
  final TextEditingController _sectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 0,
      backgroundColor: context.appColors.onBackground,
      child: Material(
        borderRadius: BorderRadius.circular(12.r),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            color: context.appColors.onBackground,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('add_new_section'),
                  style: TextStyles.regular17(),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                    child: DataTextField(
                      label: context.tr('section_title'),
                      controller: _sectionController,
                      isChoiceField: false,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _onCloseClicked();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        context.tr('close'),
                        style: TextStyles.regular13(
                          color: context.appColors.red.withOpacity(.7),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    ElevatedButton(
                      onPressed: () {
                        _onSaveRecordClicked();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        context.tr('save'),
                        style: TextStyles.regular13(
                          color: context.appColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCloseClicked() {
    Navigator.pop(context);
  }

  void _onSaveRecordClicked() {
    widget.onSectionAdded(_sectionController.text);
    Navigator.pop(context);
  }
}
