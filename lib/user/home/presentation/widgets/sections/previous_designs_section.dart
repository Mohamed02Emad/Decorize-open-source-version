import 'package:decorizer/common/util/get_file/pick_file_util.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:decorizer/user/home/presentation/cubits/home/home_cubit.dart';
import 'package:decorizer/user/saved_designs/presentation/pages/saved_designs_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav/nav.dart';

class PreviousDesignsSection extends StatelessWidget {
  const PreviousDesignsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final hasData = state.savedDesignsState.data?.isNotEmpty ?? false;
        final isSuccess = state.savedDesignsState.isSuccess;
        return DynamicContainer(
          showChild: hasData && isSuccess,
          hiddenChildWidget: SizedBox(
            height: 0,
            width: double.infinity,
          ),
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 1000),
          child: SizedBox(
            height: 105.h,
            width: double.infinity,
            child: ListView.separated(
              padding: 16.edgeInsetsHorizontal,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final image = state.savedDesignsState.data?[index].url ?? '';
                return AppImage(
                  width: 105.h,
                  height: 105.h,
                  radius: 12.h,
                  path: image,
                ).clickable(() => _openDesign(context, image));
              },
              separatorBuilder: (context, index) => 12.gap,
              itemCount: state.savedDesignsState.data?.length ?? 0,
            ),
          ).withTitle(
            title: context.tr(LocaleKeys.home_previous_designs),
            onSeeAllClicked: _onSeeAllClicked,
          ),
        );
      },
    );
  }

  void _onSeeAllClicked() {
    Nav.push(const SavedDesignsScreen());
  }

  void _openDesign(BuildContext context, String design) {
    PickFileUtil.showFileSelected(
      url: design,
    );
  }
}
