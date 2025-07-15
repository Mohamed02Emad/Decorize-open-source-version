import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/notifications/domain/models/notification_model.dart';
import 'package:decorizer/shared_features/notifications/domain/params/get_notifications_params.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationModel>>> getNotifications(
      GetNotificationsParams params);
  Future<Either<Failure, int>> getUnreadCount();
  Future<Either<Failure, Unit>> markAsRead();
}
