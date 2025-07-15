import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';

enum WorkerOrderDetailsStatus {
  pending,
  cancelled,
  completed,
  inProgress;

  bool get isPending => this == WorkerOrderDetailsStatus.pending;
  bool get isCancelled => this == WorkerOrderDetailsStatus.cancelled;
  bool get isCompleted => this == WorkerOrderDetailsStatus.completed;
  bool get isInProgress => this == WorkerOrderDetailsStatus.inProgress;

  static WorkerOrderDetailsStatus fromString(String status) {
    return WorkerOrderDetailsStatus.values.firstWhere((e) => e.statusKey == status);
  }

  static WorkerOrderDetailsStatus get random {
    final values = <WorkerOrderDetailsStatus>[...WorkerOrderDetailsStatus.values]..shuffle();
    return values.first;
  }

  String get displayName => switch (this) {
    WorkerOrderDetailsStatus.pending => LocaleKeys.order_details_offers_pending,
    WorkerOrderDetailsStatus.cancelled => LocaleKeys.order_details_offers_cancelled,
    WorkerOrderDetailsStatus.completed => LocaleKeys.order_details_offers_completed,
    WorkerOrderDetailsStatus.inProgress => LocaleKeys.order_details_offers_in_progress,
  };

  Color get color => switch (this) {
    WorkerOrderDetailsStatus.pending => const Color.fromARGB(255, 255, 149, 0),
    WorkerOrderDetailsStatus.cancelled => const Color.fromARGB(255, 52, 199, 89),
    WorkerOrderDetailsStatus.completed => const Color.fromARGB(255, 0, 122, 255),
    WorkerOrderDetailsStatus.inProgress => const Color.fromARGB(255, 52, 199, 89),
  };

  String get statusKey => switch (this) {
    WorkerOrderDetailsStatus.pending => 'pending',
    WorkerOrderDetailsStatus.cancelled => 'cancelled',
    WorkerOrderDetailsStatus.completed => 'completed',
    WorkerOrderDetailsStatus.inProgress => 'in_progress',
  };

  bool get isChatAvailable => switch (this) {
    WorkerOrderDetailsStatus.pending => false,
    WorkerOrderDetailsStatus.cancelled => false,
    WorkerOrderDetailsStatus.completed => false,
    WorkerOrderDetailsStatus.inProgress => true,
  };
}