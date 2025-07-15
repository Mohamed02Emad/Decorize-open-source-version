import 'dart:io';

import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/util/get_file/widgets/zoomable_network_image.dart';
import 'package:decorizer/common/widget/app/skeleton.dart';
import 'package:decorizer/common/widget/dynamic_container.dart';
import 'package:decorizer/user/create_design/presentation/cubits/suggest_design_cubit/suggest_design_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app/app_image.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/create_design_actions_section.dart';

class CreateDesignScreen extends StatelessWidget {
  final File image;
  final String? description;
  final String projectId;

  const CreateDesignScreen(
      {super.key,
      required this.image,
      required this.description,
      required this.projectId});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<SuggestDesignCubit>();
    cubit.suggestDesign(
        image: image,
        projectId: projectId,
        promptArabic: description ?? '',
        isRecreate: false);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => cubit),
      ],
      child: _CreateDesignScreenBody(
        image: image,
        description: description,
        projectId: projectId,
      ),
    );
  }
}

class _CreateDesignScreenBody extends StatelessWidget {
  final File image;
  final String? description;
  final String projectId;
  const _CreateDesignScreenBody(
      {required this.image,
      required this.description,
      required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SuggestDesignCubit, SuggestDesignState>(
        builder: (context, state) => Stack(
          children: [
            Positioned.fill(
              top: 52.h + MediaQuery.of(context).padding.top,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: state.suggestDesignState.isLoading
                        ? Skeleton(
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : ZoomableNetworkImage(
                            imageUrl: state.suggestDesignState.data?.imageUrl ??
                                image.path,
                          ),
                  ),
                  DynamicContainer(
                      showChild: !state.suggestDesignState.isLoading,
                      child: CreateDesignActionsSection(
                        image: image,
                        projectId: projectId,
                        description: description,
                        fileId: state.suggestDesignState.data?.fileId,
                      )),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppTitleBar(
                title: context.tr(LocaleKeys.create_design_design_section),
                hasBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
