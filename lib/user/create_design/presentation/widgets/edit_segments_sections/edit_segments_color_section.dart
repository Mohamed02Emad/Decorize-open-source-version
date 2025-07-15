import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/user/create_design/presentation/cubits/design_segments/design_segments_cubit.dart';
import 'package:decorizer/user/create_design/presentation/widgets/segment_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditSegmentsColorSection extends StatelessWidget {
  final VoidCallback onSave;

  const EditSegmentsColorSection({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DesignSegmentsCubit>();
    return cubit.segmentValueListenable(
        childBuilder: (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     AppImage(
                //       path: cubit.state.designSegmentsState.data
                //           ?.previewSegmentsImgUrl,
                //       width: context.deviceWidth / 2.2,
                //       radius: 12.r,
                //       fit: BoxFit.cover,
                //     ),
                //     AppImage(
                //       path: cubit
                //           .state.designSegmentsState.data?.originalImageUrl,
                //       width: context.deviceWidth / 2.2,
                //       radius: 12.r,
                //       fit: BoxFit.cover,
                //     ),
                //   ],
                // ).marginBottom(20.h).marginTop(12),
                20.gap,
                Expanded(
                  child: ListView(
                    children: cubit.segmentsTitlesFiltered.value.map(
                      (title) {
                        final index =
                            cubit.segmentsTitlesFiltered.value.indexOf(title);
                        final color = cubit.segmentsColorsFiltered.value[index];
                        return SegmentColorWidget(
                          title: title,
                          color: color,
                          onColorSelected: (List<int> color) {
                            cubit.changeSegmentColor(index, color);
                          },
                        )
                            .marginBottom(10.h)
                            .withBottomDivider()
                            .marginBottom(10);
                      },
                    ).toList(),
                  ),
                ),
                AppButton(
                  onClick: onSave,
                  margin: 16.edgeInsetsHorizontal.copyWith(bottom: 16.h),
                  text: LocaleKeys.action_save.tr(),
                ),
              ],
            ));
  }
}
