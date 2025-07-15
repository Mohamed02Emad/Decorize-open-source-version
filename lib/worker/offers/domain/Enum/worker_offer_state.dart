import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';

enum WorkerOfferState {
  pending,
  rejected,
  approved,
  cancelled;

bool get isPending => this == WorkerOfferState.pending;
bool get isRejected => this == WorkerOfferState.rejected;
bool get isApproved => this == WorkerOfferState.approved;
bool get isCancelled => this == WorkerOfferState.cancelled;

static WorkerOfferState fromString(String status) {
  return WorkerOfferState.values.firstWhere((e) => e.statusKey == status);
}

static WorkerOfferState get random {
  final values = <WorkerOfferState>[...WorkerOfferState.values]..shuffle();
  return values.first;
}

String get displayName => switch (this) {
  WorkerOfferState.pending => LocaleKeys.order_details_offers_pending,
  WorkerOfferState.rejected => LocaleKeys.order_details_offers_rejected,
  WorkerOfferState.approved => LocaleKeys.order_details_offers_approved,
  WorkerOfferState.cancelled => LocaleKeys.order_details_offers_cancelled,
};

Color get color => switch (this) {
  WorkerOfferState.pending => const Color.fromARGB(255, 255, 149, 0),
  WorkerOfferState.rejected => const Color.fromARGB(255, 255, 59, 48),
  WorkerOfferState.approved => const Color.fromARGB(255, 0, 122, 255),
  WorkerOfferState.cancelled => const Color.fromARGB(255, 52, 199, 89),
};

String get statusKey => switch (this) {
  WorkerOfferState.pending => 'pending',
  WorkerOfferState.rejected => 'rejected',
  WorkerOfferState.approved => 'approved',
  WorkerOfferState.cancelled => 'cancelled',
};

bool get isChatAvailable => switch (this) {
  WorkerOfferState.pending => false,
  WorkerOfferState.rejected => false,
  WorkerOfferState.approved => true,
  WorkerOfferState.cancelled => false,
};
}
