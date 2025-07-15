class DesignSegmentsModel {
  final String previewSegmentsImgUrl;
  final String originalImageUrl;
  final List<String> segmentsIds;
  final List<List<int>> segmentsColors;

  DesignSegmentsModel({
    required this.previewSegmentsImgUrl,
    required this.segmentsIds,
    required this.segmentsColors,
    required this.originalImageUrl,
  });


  DesignSegmentsModel copyWith({
    String? previewSegmentsImgUrl,
    String? originalImageUrl,
    List<String>? segmentsIds,
    List<List<int>>? segmentsColors,
  }) {
    return DesignSegmentsModel(
      previewSegmentsImgUrl: previewSegmentsImgUrl ?? this.previewSegmentsImgUrl,
      originalImageUrl: originalImageUrl ?? this.originalImageUrl,
      segmentsIds: segmentsIds ?? this.segmentsIds,
      segmentsColors: segmentsColors ?? this.segmentsColors,
    );
  }

  factory DesignSegmentsModel.fromJson(Map<String, dynamic> json) {
    return DesignSegmentsModel(
      previewSegmentsImgUrl: json['preview_segments_img_url'],
      originalImageUrl: json['image_url'],
      segmentsIds: List<String>.from(json['segments_ids']),
      segmentsColors: List<List<int>>.from(
        json['segments_colors'].map((color) => List<int>.from(color))
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preview_segments_img_url': previewSegmentsImgUrl,
      'segments_ids': segmentsIds,
      'segments_colors': segmentsColors,
    };
  }
}
