class UpdateOfferStatusParams {
  final String offerId;
  final String status;
  final String? reason;

  UpdateOfferStatusParams(
      {required this.offerId, required this.status, this.reason});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      if (reason != null) 'reason': reason,
    };
  }
}
