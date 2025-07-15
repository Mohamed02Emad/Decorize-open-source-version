import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';

enum OrderDetailsState {
  pending,
  cancelled,
  completed,
  inProgress;

  bool get isPending => this == OrderDetailsState.pending;
  bool get isCancelled => this == OrderDetailsState.cancelled;
  bool get isCompleted => this == OrderDetailsState.completed;
  bool get isInProgress => this == OrderDetailsState.inProgress;

  static OrderDetailsState fromString(String status) {
    return OrderDetailsState.values.firstWhere((e) => e.statusKey == status);
  }


  static OrderDetailsState get random {
    final values = <OrderDetailsState>[...OrderDetailsState.values]..shuffle();
    return values.first;
  }

  String get displayName => switch (this) {
        OrderDetailsState.pending => LocaleKeys.OrderScreen_pending,
        OrderDetailsState.cancelled => LocaleKeys.OrderScreen_canceled,
        OrderDetailsState.completed => LocaleKeys.OrderScreen_completed,
        OrderDetailsState.inProgress => LocaleKeys.OrderScreen_inProgress,
      };

  Color get color => switch (this) {
        OrderDetailsState.pending => const Color.fromARGB(255, 255, 149, 0),
        OrderDetailsState.cancelled => const Color.fromARGB(255, 255, 59, 48),
        OrderDetailsState.completed => const Color.fromARGB(255, 0, 122, 255),
        OrderDetailsState.inProgress => const Color.fromARGB(255, 52, 199, 89),
      };

  String get statusKey => switch (this) {
        OrderDetailsState.pending => 'pending',
        OrderDetailsState.cancelled => 'cancelled',
        OrderDetailsState.completed => 'completed',
        OrderDetailsState.inProgress => 'in_progress',
      };

  bool get showMap => this == OrderDetailsState.inProgress;
  bool get showActionButtons => this == OrderDetailsState.pending;
  bool get showCancelledMessage => this == OrderDetailsState.cancelled;
  bool get showWorkerProfile => this != OrderDetailsState.cancelled;
}
