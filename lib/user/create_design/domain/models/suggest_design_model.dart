class SuggestDesignModel {
  final bool validFile;
  final String message;
  final String projectId;
  final String fileId;
  final String imageUrl;

  SuggestDesignModel({
    required this.validFile,
    required this.message,
    required this.projectId,
    required this.fileId,
    required this.imageUrl,
  });

  factory SuggestDesignModel.fromJson(Map<String, dynamic> json) {
    return SuggestDesignModel(
      validFile: json['valid_file'] as bool,
      message: json['message'] as String,
      projectId: json['project_id'] as String,
      fileId: json['file_id'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'valid_file': validFile,
      'message': message,
      'project_id': projectId,
      'file_id': fileId,
      'image_url': imageUrl,
    };
  }
}
