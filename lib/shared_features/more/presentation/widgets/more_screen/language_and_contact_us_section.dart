import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../common/resources/gen/assets.gen.dart';
import '../../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../../common/widget/app/floating_card.dart';
import '../../../../../common/widget/dialogs/language_dialog.dart';
import '../change_mode_widget.dart';
import '../more_item.dart';

class LanguageAndContactUsSection extends StatelessWidget {
  const LanguageAndContactUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      shadowColor: context.appColors.shadowColor,
      child: Column(
        children: [
          MoreItem(
            svgAsset: Assets.image.svg.moreLanguage.path,
            title: context.tr(LocaleKeys.more_change_language),
            onClick: () => _changeLanguageClicked(context),
            trailingWidget: Text(
              context.isArabic ? 'ع' : 'EN',
              style: TextStyles.semiBold13(),
            ),
          ),
           ChangeModeWidget(),

          MoreItem(
            svgAsset: Assets.image.svg.contactUs.path,
            title: context.tr(LocaleKeys.more_contact_us),
            onClick: _contactUsClicked,
          ),
          Divider(height: 6.h),
          MoreItem(
            svgAsset: Assets.image.svg.share.path,
            title: context.tr(LocaleKeys.more_share_app),
            onClick: _shareAppClicked,
          ),
        ],
      ),
    );
  }

  void _contactUsClicked() {}

  void _shareAppClicked() {
    final appLink =
        'https://play.google.com/store/apps/details?id=com.decorizer.mobile';
    final message = '${LocaleKeys.more_download_app_message.tr()} $appLink';
    Share.share(
      message,
      subject: message,
    );
  }

  void _changeLanguageClicked(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const LanguageDialog();
        });
  }
}
