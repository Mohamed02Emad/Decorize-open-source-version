import 'package:decorizer/common/common.dart';
import 'package:decorizer/user/create_design/presentation/cubits/design_segments/design_segments_cubit.dart';
import 'package:decorizer/user/create_design/presentation/cubits/get_textures/get_textures_cubit.dart';
import 'package:decorizer/user/create_design/presentation/widgets/edit_segments_sections/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditSegmentsBottomsheet extends StatefulWidget {
  final Function(Map<String, List<int>>)? onColorsSaved;
  final Function()? onTexturesSaved;
  final String projectId;
  final String fileId;

  const EditSegmentsBottomsheet({
    super.key,
    this.onColorsSaved,
    this.onTexturesSaved,
    required this.projectId,
    required this.fileId,
  });

  static Future<void> show(
    BuildContext context, {
    required String projectId,
    required String fileId,
    Function(Map<String, List<int>>)? onColorsSaved,
    Function()? onTexturesSaved,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: context.appColors.onBackground,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        minHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      builder: (ctx) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<DesignSegmentsCubit>(),
          ),
          BlocProvider.value(
            value: context.read<GetTexturesCubit>(),
          ),
        ],
        child: EditSegmentsBottomsheet(
          projectId: projectId,
          fileId: fileId,
          onColorsSaved: onColorsSaved,
          onTexturesSaved: onTexturesSaved,
        ),
      ),
    );
  }

  @override
  State<EditSegmentsBottomsheet> createState() =>
      _EditSegmentsBottomsheetState();
}

class _EditSegmentsBottomsheetState extends State<EditSegmentsBottomsheet> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    // Initialize filters when opening bottom sheet
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DesignSegmentsCubit>().initFilteredSegments();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DesignSegmentsCubit>();
    return SizedBox(
      height: context.deviceHeight * 0.5,
      child: cubit.segmentValueListenable(
          childBuilder: (context) => Column(
                children: [
                  const EditSegmentsDragger(),
                  EditSegmentsTabButtons(
                    currentPageIndex: _currentPageIndex,
                    pageController: _pageController,
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        _currentPageIndex.value = index;
                        cubit.cancelTextureEditing();
                      },
                      children: [
                        EditSegmentsColorSection(
                          onSave: () => _onSave(context, isColorMode: true),
                        ),
                        EditSegmentsTextureSection(
                          onSave: () => _onSave(context, isColorMode: false),
                        ),
                      ],
                    ),
                  ),
                  EditSegmentsPageIndicator(
                    currentPageIndex: _currentPageIndex,
                  ),
                ],
              )),
    );
  }

  void _onSave(BuildContext context, {required bool isColorMode}) {
    FocusScope.of(context).unfocus();
    final cubit = context.read<DesignSegmentsCubit>();

    if (isColorMode) {
      // Save colors
      cubit.setColorValuesToFilter();

      // Create color map for callback
      final colorMap = <String, List<int>>{};
      for (int i = 0; i < cubit.segmentsTitles.value.length; i++) {
        colorMap[cubit.segmentsTitles.value[i]] = cubit.segmentsColors.value[i];
      }

      Nav.pop(context);
      widget.onColorsSaved?.call(colorMap);
    } else {
      // Save texture (only if in editing mode)
      if (cubit.isEditingTexture.value &&
          cubit.currentEditingTextureIndex.value != null) {
        cubit.saveTextureChanges(
          projectId: widget.projectId,
          fileId: widget.fileId,
        );

        // Listen for success to close bottom sheet
        cubit.stream.listen((state) {
          if (state.changeSegmentTextureState.isSuccess) {
            Nav.pop(context);
            widget.onTexturesSaved?.call();
          }
        });
      }
    }
  }
}
