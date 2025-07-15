import 'dart:io';

import 'package:decorizer/common/util/image_util.dart';
import 'package:decorizer/common/util/screenshot_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin DesignSegmentsCubitVariables {
  ValueNotifier<List<String>> segmentsTitles = ValueNotifier([]);
  ValueNotifier<List<List<int>>> segmentsColors = ValueNotifier([]);
  ValueNotifier<List<File?>> selectedSegmentTextures = ValueNotifier([]);

  ValueNotifier<List<String>> segmentsTitlesFiltered = ValueNotifier([]);
  ValueNotifier<List<List<int>>> segmentsColorsFiltered = ValueNotifier([]);
  ValueNotifier<List<File?>> selectedSegmentTexturesFiltered =
      ValueNotifier([]);

  // Texture editing state
  ValueNotifier<int?> currentEditingTextureIndex = ValueNotifier(null);
  ValueNotifier<bool> isEditingTexture = ValueNotifier(false);
  Map<String, File> pendingTextureChanges = {};

  Widget segmentValueListenable(
      {required Widget Function(BuildContext context) childBuilder}) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: segmentsTitlesFiltered,
      builder: (context, titles, _) {
        return ValueListenableBuilder<List<List<int>>>(
          valueListenable: segmentsColorsFiltered,
          builder: (context, colors, _) {
            return ValueListenableBuilder<List<File?>>(
              valueListenable: selectedSegmentTexturesFiltered,
              builder: (context, textures, _) {
                return ValueListenableBuilder<int?>(
                  valueListenable: currentEditingTextureIndex,
                  builder: (context, editingIndex, _) {
                    return childBuilder(context);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void initFilteredSegments() {
    segmentsTitlesFiltered.value = segmentsTitles.value;
    segmentsColorsFiltered.value = segmentsColors.value;
    selectedSegmentTexturesFiltered.value = selectedSegmentTextures.value;
  }

  void initTextureEditingMode(int segmentIndex) {
    currentEditingTextureIndex.value = segmentIndex;
    isEditingTexture.value = true;

    // Show only the selected segment for texture editing
    segmentsTitlesFiltered.value = [segmentsTitles.value[segmentIndex]];
    selectedSegmentTexturesFiltered.value = [
      selectedSegmentTextures.value[segmentIndex]
    ];
  }

  void resetTextureEditingMode() {
    currentEditingTextureIndex.value = null;
    isEditingTexture.value = false;
    pendingTextureChanges.clear();

    // Reset filtered values to show all segments
    initFilteredSegments();
  }

  void setValuesToFilters() {
    segmentsTitles.value = segmentsTitlesFiltered.value;
    segmentsColors.value = segmentsColorsFiltered.value;
    selectedSegmentTextures.value = selectedSegmentTexturesFiltered.value;
  }

  void setColorValuesToFilter() {
    segmentsTitles.value = segmentsTitlesFiltered.value;
    segmentsColors.value = segmentsColorsFiltered.value;
  }

  void setTextureValuesToFilter() {
    // Only update the specific texture being edited
    final editingIndex = currentEditingTextureIndex.value;
    if (editingIndex != null) {
      final updatedTextures = [...selectedSegmentTextures.value];

      // Ensure we don't go out of bounds
      if (editingIndex < updatedTextures.length) {
        // Get the texture from filtered arrays (could be null if cleared)
        final newTexture = selectedSegmentTexturesFiltered.value.isNotEmpty
            ? selectedSegmentTexturesFiltered.value[0]
            : null;

        updatedTextures[editingIndex] = newTexture;

        selectedSegmentTextures.value = updatedTextures;
      }
    }
  }

  void changeSegmentColor(int index, List<int> color) {
    final oldColors = [...segmentsColorsFiltered.value];
    oldColors[index] = color;
    segmentsColorsFiltered.value = oldColors;
  }

  void changeSegmentTexture(int index, File? texture) {
    // In texture editing mode, index will always be 0 since we show only one segment
    final oldTextures = [...selectedSegmentTexturesFiltered.value];

    oldTextures[index] = texture;
    // Clear URL when local file is selected

    selectedSegmentTexturesFiltered.value = oldTextures;

    // Store pending change
    final editingIndex = currentEditingTextureIndex.value;
    if (editingIndex != null && texture != null) {
      pendingTextureChanges[segmentsTitles.value[editingIndex]] = texture;
    }
  }

  void changeSegmentTextureUrl(int i, String? url) async {
    clearSegmentTexture(i);
    final oldTextures = [...selectedSegmentTexturesFiltered.value];
    final downloadedTextureRaw = await ImageUtil.downloadImage(url ?? '');
    // Generate unique filename to avoid caching issues
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final downloadedTexture = await ScreenShotHelper.writeUint8ListToTempFile(
      downloadedTextureRaw ?? Uint8List(0),
      fileName: 'texture_${timestamp}_${url?.hashCode ?? 0}.png'
    );
    oldTextures[i] = downloadedTexture;
    selectedSegmentTexturesFiltered.value = oldTextures;
    final editingIndex = currentEditingTextureIndex.value;
    if (editingIndex != null && downloadedTexture != null) {
          pendingTextureChanges[segmentsTitles.value[editingIndex]] =
          downloadedTexture;
    }
  }

  void clearSegmentTexture(int index) {
    final oldTextures = [...selectedSegmentTexturesFiltered.value];

    oldTextures[index] = null;

    selectedSegmentTexturesFiltered.value = oldTextures;

    // Remove pending change
    final editingIndex = currentEditingTextureIndex.value;
    if (editingIndex != null) {
      pendingTextureChanges.remove(segmentsTitles.value[editingIndex]);
    }
  }

  // Get only the pending texture changes for the current editing session
  Map<String, File> getPendingTextureChanges() {
    return Map.from(pendingTextureChanges);
  }

  // Fake texture URLs for dropdown
  List<String> get fakeTextureUrls => [
        'https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1615529328331-f8917597711f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1615529328331-f8917597711f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      ];
}
