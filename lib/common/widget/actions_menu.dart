import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/color_extension.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:flutter/material.dart';

import '../resources/gen/assets.gen.dart';

class ActionsMenu extends StatelessWidget {
  final bool isLoading;
  final double? size;
  final Widget? icon;
  final List<ActionMenuItem> actions;

  const ActionsMenu({
    super.key,
    required this.actions,
    this.isLoading = false,
    this.icon,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 32,
      width: size ?? 32,
      child: isLoading
          ? const Center(child: AppLoading())
          : FittedBox(
              child: PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                color: context.appColors.onBackground,
                icon: icon ??
                    SvgPicture.asset(
                      Assets.image.svg.info.path,
                      width: size ?? 39,
                      height: size ?? 39,
                      colorFilter: context.appColors.text.colorFilter,
                    ),
                onSelected: (value) {
                  actions.firstWhere((action) => action.title == value).onTap();
                },
                itemBuilder: (BuildContext context) => actions
                    .map(
                      (action) => PopupMenuItem<String>(
                        value: action.title,
                        child: Row(
                          children: [
                            if (action.icon != null) action.icon!,
                            const SizedBox(width: 4),
                            Text(
                              action.title,
                              style: TextStyles.regular12(
                                color: action.textColor ?? context.appColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}

class ActionMenuItem {
  final String title;
  final Function() onTap;
  final Color? textColor;
  final Widget? icon;

  ActionMenuItem({required this.title, required this.onTap, this.textColor, this.icon});
}
