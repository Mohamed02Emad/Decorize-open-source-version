import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/language/language_enum.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/textStyles.dart';
import '../../data/preference/app_preferences.dart';
import '../../data/preference/item/preference_item.dart';
import '../app/app_button.dart';
import '../spaces.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({
    super.key,
  });

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  LanguageEnum selectedLanguage = LanguageEnum.en;
  LanguageEnum? currentSelectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = LanguageEnum.en;
  }

  @override
  void didChangeDependencies() {
    if (currentSelectedLanguage != null) return;
    final currentLangString =
        EasyLocalization.of(context)?.currentLocale?.languageCode ?? 'en';
    currentSelectedLanguage =
        currentLangString == 'ar' ? LanguageEnum.ar : LanguageEnum.en;
    setState(() {
      selectedLanguage = currentSelectedLanguage!;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final scaledRadius = 12.r;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scaledRadius),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Material(
        borderRadius: BorderRadius.circular(scaledRadius),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            color: context.appColors.onBackground,
            borderRadius: BorderRadius.circular(scaledRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                child: Text(
                  LocaleKeys.common_language.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyles.bold18(context: context),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Width(16.w),
                  Expanded(
                    child: _LanguageCard(
                      language: LanguageEnum.ar,
                      isSelected: selectedLanguage == LanguageEnum.ar,
                      onSelected: _updateSelectedLanguage,
                    ),
                  ),
                  Width(24.w),
                  Expanded(
                    child: _LanguageCard(
                      language: LanguageEnum.en,
                      isSelected: selectedLanguage == LanguageEnum.en,
                      onSelected: _updateSelectedLanguage,
                    ),
                  ),
                  Width(16.w),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              AppButton(
                  text: LocaleKeys.action_next.tr(),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  onClick: () => _onChangeLanguage(context)),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onChangeLanguage(BuildContext context) async {
    currentSelectedLanguage = selectedLanguage;
    PreferenceItem<String>(AppPreferences.language, selectedLanguage.name)
        .set(selectedLanguage.name);
    await context.setLocale(Locale(selectedLanguage.name));
    Nav.pop(context);
  }

  _updateSelectedLanguage(LanguageEnum language) {
    setState(() {
      selectedLanguage = language;
    });
  }
}

class _LanguageCard extends StatelessWidget {
  final LanguageEnum language;
  final bool isSelected;
  final Function(LanguageEnum) onSelected;

  const _LanguageCard(
      {required this.language,
      required this.isSelected,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.h,
          decoration: BoxDecoration(
            color: isSelected
                ? context.appColors.primary.withOpacity(0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color:
                    isSelected ? context.appColors.primary : Colors.transparent,
                width: 1.h),
          ),
          child: Center(
            child: SvgPicture.asset(
              language.flagPath,
              height: 55.h,
            ),
          ).clickable(() => onSelected(language)),
        ),
        Height(12.h),
        Text(language.displayName),
      ],
    );
  }
}
