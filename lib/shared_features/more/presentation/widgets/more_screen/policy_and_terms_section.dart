import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/shared_features/auth/domain/enums/user_type.dart';
import 'package:decorizer/shared_features/more/domain/enums/static_page_type.dart';
import 'package:decorizer/shared_features/more/presentation/pages/static_pages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/resources/gen/assets.gen.dart';
import '../../../../../common/resources/gen/locale_keys.g.dart';
import '../../../../../common/util/guest_util.dart';
import '../../../../../common/widget/app/floating_card.dart';
import '../../../../../user/saved_designs/presentation/pages/saved_designs_screen.dart';
import '../more_item.dart';

class PolicyAndTermsSection extends StatelessWidget {
  const PolicyAndTermsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final UserType? currentUserType = context.currentUserType;

    return FloatingCard(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      shadowColor: context.appColors.shadowColor,
      child: Column(
        children: [
          if (GuestUtil.isGuest.not() && currentUserType == UserType.user) ...{
            MoreItem(
              svgAsset: Assets.image.svg.savedDesigns.path,
              title: context.tr(LocaleKeys.more_saved_designs),
              onClick: _savedDesignsClicked,
            ),
            Divider(height: 6.h),
          },
          MoreItem(
            svgAsset: Assets.image.svg.terms.path,
            title: context.tr(LocaleKeys.more_terms_and_conditions),
            onClick: () {
              _termsClicked();
            },
          ),
          Divider(height: 6.h),
          // if(GuestUtil.isGuest.not())...{
          //   MoreItem(
          //     svgAsset: Assets.image.svg.chat.path,
          //     title: context.tr(
          //         LocaleKeys.more_chats),
          //     onClick: _chatsClicked,
          //   ),
          //   Divider(height: 6.h),
          // },
          MoreItem(
            svgAsset: Assets.image.svg.policy.path,
            title: context.tr(LocaleKeys.more_privacy_policy),
            onClick: () {
              _privacyPolicyClicked();
            },
          ),
        ],
      ),
    );
  }

  void _termsClicked() {
    Nav.push(StaticPagesScreen(type: StaticPageType.terms));
  }

  void _privacyPolicyClicked() {
    Nav.push(StaticPagesScreen(type: StaticPageType.policy));
  }

  void _savedDesignsClicked() {
    Nav.push(const SavedDesignsScreen());
  }
}
