import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/constant/textStyles.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_button.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/user/create_design/presentation/cubits/design_segments/design_segments_cubit.dart';
import 'package:decorizer/user/create_design/presentation/cubits/get_textures/get_textures_cubit.dart';
import 'package:decorizer/user/create_design/presentation/widgets/segment_texture_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditSegmentsTextureSection extends StatelessWidget {
  final VoidCallback onSave;

  const EditSegmentsTextureSection({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DesignSegmentsCubit>();
    return cubit.segmentValueListenable(
      childBuilder: (context) {
        final isEditingTexture = cubit.isEditingTexture.value;

        return ValueListenableBuilder(
          valueListenable: cubit.currentEditingTextureIndex,
          builder: (context, editingIndex, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (!isEditingTexture) ...[
                  _buildSegmentSelectionView(context, cubit),
                ] else if (editingIndex != null) ...[
                  _buildTextureEditingView(context, cubit, editingIndex),
                ],
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSegmentSelectionView(
      BuildContext context, DesignSegmentsCubit cubit) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.gap,
                Expanded(
                  child: ListView(
                    children: cubit.segmentsTitles.value.map((title) {
                      final index = cubit.segmentsTitles.value.indexOf(title);
                      final texture =
                          cubit.selectedSegmentTextures.value[index];
                      final hasTexture = texture != null;

                      return Container(
                        margin: 16.edgeInsetsHorizontal.copyWith(bottom: 12.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: context.appColors.grey_2
                                  .withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                  color: context.appColors.grey_2
                                      .withValues(alpha: 0.3)),
                              color: context.appColors.background,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: hasTexture
                                  ? AppImage(
                                      path: null,
                                      file: texture,
                                      width: 50.w,
                                      height: 50.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.texture,
                                      color: context.appColors.grey_2,
                                      size: 20.h,
                                    ),
                            ),
                          ),
                          title: Text(title, style: TextStyles.semiBold14()),
                          subtitle: Text(
                            hasTexture
                                ? LocaleKeys.create_design_tap_to_edit_texture
                                    .tr()
                                : LocaleKeys.create_design_no_texture_tap_to_add
                                    .tr(),
                            style: TextStyles.regular12(
                              color: hasTexture
                                  ? context.appColors.primary
                                  : context.appColors.grey_2,
                            ),
                          ),
                          trailing: Icon(Icons.edit,
                              color: context.appColors.primary),
                          onTap: () {
                            cubit.startTextureEditing(index);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextureEditingView(
      BuildContext context, DesignSegmentsCubit cubit, int editingIndex) {
    return Expanded(
      child: Column(
        children: [
          // Back button and title
          Container(
            padding: 16.edgeInsetsHorizontal,
            child: Row(
              children: [
                // IconButton(
                //   onPressed: () => cubit.cancelTextureEditing(),
                //   icon:
                //       Icon(Icons.arrow_back, color: context.appColors.primary),
                // ),
                Text(
                  LocaleKeys.create_design_editing_segment.tr(namedArgs: {
                    'segment_name': cubit.segmentsTitles.value.first
                  }),
                  style: TextStyles.semiBold16(),
                ),
              ],
            ),
          ).marginTop(16.h).marginBottom(8.h),

          // Texture editing widget
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BlocBuilder<GetTexturesCubit, GetTexturesState>(
                  builder: (context, texturesState) {
                    return SegmentTextureWidget(
                      title: cubit.segmentsTitlesFiltered.value.isNotEmpty
                          ? cubit.segmentsTitlesFiltered.value.first
                          : "",
                      localTexture: cubit
                              .selectedSegmentTexturesFiltered.value.isNotEmpty
                          ? cubit.selectedSegmentTexturesFiltered.value.first
                          : null,
                      selectedTexture: null,
                      availableTextures:
                          texturesState.getTexturesState.data ?? [],
                      onLocalTextureSelected: (texture) {
                        cubit.changeSegmentTexture(0, texture);
                      },
                      onTextureSelected: (textureModel) {
                        if (textureModel != null) {
                          cubit.changeSegmentTextureUrl(0, textureModel.image);
                        }
                      },
                      onClearTexture: () {
                        cubit.clearSegmentTexture(0);
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          // Save button
          BlocBuilder<DesignSegmentsCubit, DesignSegmentsState>(
            builder: (context, state) {
              return AppButton(
                onClick: onSave,
                margin: 16.edgeInsetsHorizontal.copyWith(bottom: 16.h),
                text: LocaleKeys.action_save.tr(),
                isLoading: state.changeSegmentTextureState.isLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
