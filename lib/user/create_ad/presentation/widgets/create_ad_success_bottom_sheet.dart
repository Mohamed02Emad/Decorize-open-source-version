import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';

class CreateAdSuccessBottomSheet extends StatelessWidget {
  const CreateAdSuccessBottomSheet._({
    required this.onCreateNewAd,
    required this.onShowMyAds,
  });
  final Function() onCreateNewAd;
  final Function() onShowMyAds;

  static void show({
    required BuildContext context,
    required Function() onCreateNewAd,
    required Function() onShowMyAds,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return CreateAdSuccessBottomSheet._(
          onCreateNewAd: onCreateNewAd,
          onShowMyAds: onShowMyAds,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.close, color: Colors.grey),
            ),
          ),
          SizedBox(height: 8),

          // Success icon
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.green.shade100,
            foregroundColor: Colors.green,
            child: Icon(Icons.check, color: Colors.white, size: 32),
          ),
          SizedBox(height: 16),

          // Title
          Text(context.tr(LocaleKeys.create_ad_create_ad_success_title),
              textAlign: TextAlign.center,
              style: TextStyles.semiBold18(
                context: context,
                color: Colors.black,
              )),
          SizedBox(height: 12),

          // Description
          Text(
            context.tr(LocaleKeys.create_ad_create_ad_success_description),
            textAlign: TextAlign.center,
            style: TextStyles.regular14Weight400(
              context: context,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Nav.pop(context);
                    onCreateNewAd();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: context.appColors.primary),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    context.tr(LocaleKeys.create_ad_create_ad_success_button),
                    style: TextStyle(color: context.appColors.primary),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Nav.pop(context);
                    onShowMyAds();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(context.tr(LocaleKeys.create_ad_create_ad_success_button_text),
                      style: TextStyles.semiBold14(
                        context: context,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
