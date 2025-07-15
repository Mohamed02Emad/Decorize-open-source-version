class SegmentsParams {
  final String fileId;
  final String projectId;

  SegmentsParams({required this.fileId, required this.projectId});

  Map<String, dynamic> toJson() {
    return {
      "file_id": fileId,
    };
  }
}
