class UpdateOrderStatusParams {
  final String orderId;
  final String status;
  final String? reason;

  UpdateOrderStatusParams({required this.orderId, required this.status, this.reason});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      if (reason != null) 'reason': reason,
    };
  }
}
