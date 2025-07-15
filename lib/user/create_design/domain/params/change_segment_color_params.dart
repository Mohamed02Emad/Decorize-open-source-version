class ChangeSegmentColorParams {
  final String fileId;
  final String projectId;
  final List<String> segmentIds;
  final List<List<int>> colors;

  ChangeSegmentColorParams({required this.fileId, required this.projectId, required this.segmentIds, required this.colors});

  Map<String, dynamic> toJson() {
    final body = <String, dynamic>{
      "file_id": fileId,
      "segments": segmentIds.map((segmentId) => {
        "segment_id": segmentId,
        "color": colors[segmentIds.indexOf(segmentId)],
      }).toList(),
    };
    return body;
  }
}
