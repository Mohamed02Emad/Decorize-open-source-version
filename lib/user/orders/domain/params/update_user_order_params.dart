class UpdateUserOrderParams {
  final String id;
  final String status;
  const UpdateUserOrderParams({required this.id, required this.status});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
