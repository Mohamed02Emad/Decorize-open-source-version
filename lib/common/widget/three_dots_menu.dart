import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';
import 'package:flutter/material.dart';

class ThreeDotsMenu extends StatelessWidget {
  final bool isLoading;
  final List<PopupMenuEntry<String>> actions;
  final Function(String)? onSelected;

  const ThreeDotsMenu(
      {super.key,
      this.isLoading = false,
      required this.actions,
      this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      width: 26,
      child: isLoading
          ? const Center(
              child: AppLoading(),
            )
          : FittedBox(
              child: PopupMenuButton<String>(
                color: context.appColors.onBackground,
                icon: const Icon(
                  Icons.more_vert,
                  size: 40,
                ),
                onSelected: (value) {
                  if (onSelected != null) {
                    onSelected!(value);
                  }
                },
                itemBuilder: (BuildContext context) => actions,
              ),
            ),
    );
  }
}
