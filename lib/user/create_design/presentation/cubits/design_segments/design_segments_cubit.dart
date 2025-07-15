import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/models/design_segments_model.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_color_params.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_texture_params.dart';
import 'package:decorizer/user/create_design/domain/params/segments_params.dart';
import 'package:decorizer/user/create_design/domain/usecases/change_segment_color_usecase.dart';
import 'package:decorizer/user/create_design/domain/usecases/change_segment_texture_usecase.dart';
import 'package:decorizer/user/create_design/domain/usecases/design_segments_usecase.dart';
import 'package:decorizer/user/create_design/presentation/cubits/design_segments/design_segments_cubit_variables.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
part 'design_segments_state.dart';

@Injectable()
class DesignSegmentsCubit extends BaseCubit<DesignSegmentsState>
    with DesignSegmentsCubitVariables {
  final DesignSegmentsUsecase designSegmentsUsecase;
  final ChangeSegmentColorUsecase changeSegmentColorUsecase;
  final ChangeSegmentTextureUsecase changeSegmentTextureUsecase;

  DesignSegmentsCubit(this.designSegmentsUsecase,
      this.changeSegmentColorUsecase, this.changeSegmentTextureUsecase)
      : super(DesignSegmentsState.initial());

  Future<void> getDesignSegments({
    required String projectId,
    required String fileId,
  }) async {
    if (state.designSegmentsState.isLoading) return;

    final params = SegmentsParams(
      projectId: projectId,
      fileId: fileId,
    );

    callAndFold(
      future: designSegmentsUsecase(params),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(designSegmentsState: requestState)),
      success: (segments) {
        segmentsTitles.value = segments.segmentsIds;
        segmentsColors.value = segments.segmentsColors;
        selectedSegmentTextures.value =
            List.filled(segments.segmentsIds.length, null);
        emit(state.copyWith(
            designSegmentsState: RequestState.success(segments)));
      },
    );
  }

  Future<void> updateSegmentsColors({
    required String projectId,
    required List<String> segmentIds,
    required String fileId,
    required List<List<int>> colors,
  }) async {
    if (state.designSegmentsState.isLoading) return;
    final segments = state.designSegmentsState.data;
    final params = ChangeSegmentColorParams(
      projectId: projectId,
      segmentIds: segmentIds,
      fileId: fileId,
      colors: colors,
    );

    emit(state.copyWith(
        designSegmentsState: RequestState.loading(),
        changeSegmentColorState: RequestState.loading()));
    final result = await changeSegmentColorUsecase(params);
    result.fold((Failure error) {
      emit(state.copyWith(
          changeSegmentColorState: RequestState.error(error.message),
          designSegmentsState: RequestState.success(segments)));
    }, (newImage) async {
      setColorValuesToFilter();
      emit(state.copyWith(
          designSegmentsState: RequestState.success(
            segments?.copyWith(
                originalImageUrl:
                    '$newImage?t=${DateTime.now().millisecondsSinceEpoch}'),
          ),
          changeSegmentColorState: RequestState.success(
              '$newImage?t=${DateTime.now().millisecondsSinceEpoch}')));
    });
  }

  Future<void> updateSegmentTextures({
    required String projectId,
    required String fileId,
    required Map<String, File> textureFiles,
  }) async {
    if (state.designSegmentsState.isLoading) return;

    try {
      final segments = state.designSegmentsState.data;

      emit(state.copyWith(
          designSegmentsState: RequestState.loading(),
          changeSegmentTextureState: RequestState.loading()));

      String? updatedImageUrl;

      // Process each texture file
      for (final entry in textureFiles.entries) {
        final segmentId = entry.key;
        final textureFile = entry.value;

        final params = ChangeSegmentTextureParams(
          projectId: projectId,
          segmentId: segmentId,
          fileId: fileId,
          texture: textureFile,
        );

        final result = await changeSegmentTextureUsecase(params);

        await result.fold((Failure error) async {
          emit(state.copyWith(
              changeSegmentTextureState: RequestState.error(error.message),
              designSegmentsState: RequestState.success(segments)));
          return;
        }, (newImage) async {
          // Handle the response like in color change - it should be the updated image URL
          if (newImage.isNotEmpty) {
            updatedImageUrl = newImage;
          }
        });
      }

      // After all textures are processed successfully
      setTextureValuesToFilter();

      final updatedSegments = updatedImageUrl != null
          ? segments?.copyWith(
              originalImageUrl:
                  '$updatedImageUrl?t=${DateTime.now().millisecondsSinceEpoch}')
          : segments;

      emit(state.copyWith(
          designSegmentsState: RequestState.success(updatedSegments),
          changeSegmentTextureState: RequestState.success(updatedImageUrl !=
                  null
              ? '$updatedImageUrl?t=${DateTime.now().millisecondsSinceEpoch}'
              : '')));
    } catch (e) {
      emit(state.copyWith(
          changeSegmentTextureState: RequestState.error(e.toString()),
          designSegmentsState:
              RequestState.success(state.designSegmentsState.data)));
    }
  }

  Future<void> updateSegmentTexturesForEditingSession({
    required String projectId,
    required String fileId,
  }) async {
    if (state.designSegmentsState.isLoading) return;

    try {
      final segments = state.designSegmentsState.data;

      // Get only the pending texture changes for this editing session
      final pendingChanges = getPendingTextureChanges();
      if (pendingChanges.isEmpty) {
        emit(state.copyWith(
            changeSegmentTextureState:
                RequestState.error("No texture changes to save")));
        return;
      }

      emit(state.copyWith(
          designSegmentsState: RequestState.loading(),
          changeSegmentTextureState: RequestState.loading()));

      // Send only the single texture that was changed
      final entry = pendingChanges.entries.first;
      final params = ChangeSegmentTextureParams(
        projectId: projectId,
        segmentId: entry.key,
        fileId: fileId,
        texture: entry.value,
      );

      final result = await changeSegmentTextureUsecase(params);

      result.fold((Failure error) {
        emit(state.copyWith(
            changeSegmentTextureState: RequestState.error(error.message),
            designSegmentsState: RequestState.success(segments)));
      }, (newImage) async {
        // Save the texture to main state BEFORE clearing pending changes
        setTextureValuesToFilter();

        // Clear pending changes after successful save
        pendingTextureChanges.clear();
        resetTextureEditingMode();

        // Handle the response like in color change - it should be the updated image URL
        final updatedSegments = segments?.copyWith(
            originalImageUrl:
                '$newImage?t=${DateTime.now().millisecondsSinceEpoch}');

        emit(state.copyWith(
            designSegmentsState: RequestState.success(updatedSegments),
            changeSegmentTextureState: RequestState.success(
                '$newImage?t=${DateTime.now().millisecondsSinceEpoch}')));
      });
    } catch (e) {
      emit(state.copyWith(
          changeSegmentTextureState: RequestState.error(e.toString()),
          designSegmentsState:
              RequestState.success(state.designSegmentsState.data)));
    }
  }

  Future<File?> downloadTextureFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final fileName = url.split('/').last.split('?').first;
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
    } catch (e) {
      debugPrint('Error downloading texture: $e');
    }
    return null;
  }

  void startTextureEditing(int segmentIndex) {
    initTextureEditingMode(segmentIndex);
  }

  void cancelTextureEditing() {
    resetTextureEditingMode();
  }

  void saveTextureChanges({
    required String projectId,
    required String fileId,
  }) {
    updateSegmentTexturesForEditingSession(
      projectId: projectId,
      fileId: fileId,
    );
  }

}
