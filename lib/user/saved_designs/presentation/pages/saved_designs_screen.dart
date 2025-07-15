import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/get_file/pick_file_util.dart';
import 'package:decorizer/common/widget/animations/fade.dart';
import 'package:decorizer/common/widget/animations/scale.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_error_widget.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:decorizer/user/saved_designs/presentation/cubits/saved_designs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SavedDesignsScreen extends StatelessWidget {
  const SavedDesignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SavedDesignsCubit>()..startPagination(),
      child: const _SavedDesignsScreenBody(),
    );
  }
}

class _SavedDesignsScreenBody extends StatelessWidget {
  const _SavedDesignsScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        title: context.tr(LocaleKeys.more_saved_designs),
        hasBackButton: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<SavedDesignsCubit>().refresh(),
        child: PagedGridView<int, ImageModel>(
          pagingController:
              context.read<SavedDesignsCubit>().paginateController,
          padding: 16.edgeInsetsHorizontal.copyWith(top: 16.h, bottom: 40.h),
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1,
          ),
          builderDelegate: PagedChildBuilderDelegate<ImageModel>(
            itemBuilder: (context, image, index) {
              final radius = 15.h;
              return FadeAppearWrapper(
                beginOpacity: 0.4,
                child: ScaleWrapper(
                  duration: 200.duration,
                  child: AppImage(
                    width: double.infinity,
                    height: double.infinity,
                    radius: radius,
                    path: image.url,
                  )
                      .clickable(() => _openDesign(context, image.url),
                          radius: radius)
                      .withShadow(radius),
                ),
              );
            },
            firstPageErrorIndicatorBuilder: (context) => AppErrorWidget(
              errorMessage: context.tr(LocaleKeys.error_error_happened),
              onRefresh: () => context.read<SavedDesignsCubit>().refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) => Center(
              child: Text(context.tr(LocaleKeys.error_error_no_results)),
            ),
          ),
        ),
      ),
    );
  }

  void _openDesign(BuildContext context, String image) {
    PickFileUtil.showFileSelected(url: image);
  }
}
