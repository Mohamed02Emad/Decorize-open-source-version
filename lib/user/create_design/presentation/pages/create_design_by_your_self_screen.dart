import 'dart:io';
import 'dart:math';

import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/di/injection_container.dart';

import 'package:decorizer/common/util/get_file/widgets/zoomable_network_image.dart';
import 'package:decorizer/common/util/navigation_helper.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:decorizer/common/widget/app/state_widgets/app_loading.dart';

import 'package:decorizer/user/create_design/domain/models/design_segments_model.dart';
import 'package:decorizer/user/create_design/domain/models/upload_design_model.dart';
import 'package:decorizer/user/create_design/presentation/cubits/design_segments/design_segments_cubit.dart';
import 'package:decorizer/user/create_design/presentation/cubits/exit_design/exit_design_cubit.dart';
import 'package:decorizer/user/create_design/presentation/cubits/get_textures/get_textures_cubit.dart';
import 'package:decorizer/user/create_design/presentation/cubits/open_design/open_design_cubit.dart';
import 'package:decorizer/user/create_design/presentation/cubits/save_design/save_design_cubit.dart';
import 'package:decorizer/user/create_design/presentation/cubits/upload_ai_image/upload_ai_image_cubit.dart';
import 'package:decorizer/user/create_design/presentation/widgets/design_yourself_bottom_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDesignByYourSelfScreen extends StatelessWidget {
  final File image;
  final String projectId;

  const CreateDesignByYourSelfScreen(
      {super.key, required this.image, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UploadAiImageCubit>()
            ..init(image: image, projectId: projectId)
            ..uploadAiImage(),
        ),
        BlocProvider(create: (context) => sl<DesignSegmentsCubit>()),
        BlocProvider(create: (context) => sl<ExitDesignCubit>()),
        BlocProvider(create: (context) => sl<OpenDesignCubit>()),
        BlocProvider(create: (context) => sl<SaveDesignCubit>()),
        BlocProvider(create: (context) => sl<GetTexturesCubit>()..getTextures()),
      ],
      child: _CreateDesignByYourSelfScreenBody(),
    );
  }
}

class _CreateDesignByYourSelfScreenBody extends StatelessWidget {
  const _CreateDesignByYourSelfScreenBody();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        title: context.tr(LocaleKeys.create_design_design_yourself),
        hasBackButton: true,
        actions: BlocConsumer<SaveDesignCubit, SaveDesignState>(
          listener: (context, state) => state.saveDesignState.listen(
            onSuccess: (data, message) {
              showSuccessToast(message ?? 'Design saved successfully');
              popToFirst(context);
            },
            onError: (error) {
              showErrorToast(error);
            },
          ),
          builder: (context, state) {
            return IconButton(
              onPressed: state.saveDesignState.isLoading
                  ? null
                  : () => context.read<SaveDesignCubit>().saveDesign(
                        title:
                            'Design ${DateTime.now().millisecondsSinceEpoch} ${Random().nextInt(999999999)}',
                        imageUrl: context
                                .read<DesignSegmentsCubit>()
                                .state
                                .designSegmentsState
                                .data
                                ?.originalImageUrl ??
                            '',
                      ),
              icon: state.saveDesignState.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: AppLoading(size: 20),
                    )
                  : Icon(Icons.save,
                      color: context.isDarkMode ? context.appColors.text : context.appColors.primary),
            );
          },
        ),
      ),
      body: BlocConsumer<UploadAiImageCubit, UploadAiImageState>(
        listener: (context, state) => state.uploadAiImageState.listen(
          onSuccess: (designModel, message) {
            context.read<DesignSegmentsCubit>().getDesignSegments(
                  projectId: designModel.projectId,
                  fileId: designModel.fileId,
                );
          },
        ),
        builder: (context, state) => state.uploadAiImageState.build(
          onRetry: () => _refresh(context),
          successBuilder: (UploadDesignModel designModel) {
            return BlocBuilder<DesignSegmentsCubit, DesignSegmentsState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: state.designSegmentsState.build(
                        loadingWidget: const Skeleton(
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        successBuilder: (DesignSegmentsModel segments) =>
                            ZoomableNetworkImage(
                          imageUrl: segments.originalImageUrl,
                        ),
                      ),
                    ),
                    state.designSegmentsState.data != null
                        ? DesignYourselfBottomSection(
                            segments: state.designSegmentsState.data!)
                        : const SizedBox.shrink(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _refresh(BuildContext context) {
    context.read<UploadAiImageCubit>().uploadAiImage();
  }
}
