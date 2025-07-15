import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';

enum OfferState {
  pending,
  rejected,
  approved,
  cancelled;

  bool get isPending => this == OfferState.pending;
  bool get isRejected => this == OfferState.rejected;
  bool get isApproved => this == OfferState.approved;
  bool get isCancelled => this == OfferState.cancelled;

  static OfferState fromString(String status) {
    return OfferState.values.firstWhere((e) => e.statusKey == status);
  }

  static OfferState get random {
    final values = <OfferState>[...OfferState.values]..shuffle();
    return values.first;
  }

  String get displayName => switch (this) {
        OfferState.pending => LocaleKeys.order_details_offers_pending,
        OfferState.rejected => LocaleKeys.order_details_offers_rejected,
        OfferState.approved => LocaleKeys.order_details_offers_approved,
        OfferState.cancelled => LocaleKeys.order_details_offers_cancelled,

      };

  Color get color => switch (this) {
        OfferState.pending => const Color.fromARGB(255, 255, 149, 0),
        OfferState.rejected => const Color.fromARGB(255, 255, 59, 48),
        OfferState.approved => const Color.fromARGB(255, 0, 122, 255),
        OfferState.cancelled => const Color.fromARGB(255, 52, 199, 89),

      };

  String get statusKey => switch (this) {
        OfferState.pending => 'pending',
        OfferState.rejected => 'rejected',
        OfferState.approved => 'approved',
        OfferState.cancelled => 'cancelled',

      };

  bool get isChatAvailable => switch (this) {
        OfferState.pending => false,
        OfferState.rejected => false,
        OfferState.approved => true,
        OfferState.cancelled => false,
      };
}
