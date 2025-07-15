class UploadDesignModel {
  final bool validFile;
  final String message;
  final String projectId;
  final String fileId;

  UploadDesignModel({
    required this.validFile,
    required this.message,
    required this.projectId,
    required this.fileId,
  });

  factory UploadDesignModel.fromJson(Map<String, dynamic> json) {
    return UploadDesignModel(
      validFile: json['valid_file'],
      message: json['message'],
      projectId: json['project_id'],
      fileId: json['file_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'valid_file': validFile,
      'message': message,
      'project_id': projectId,
      'file_id': fileId,
    };
  }
}
