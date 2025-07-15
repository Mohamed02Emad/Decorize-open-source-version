import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:decorizer/shared_features/notifications/domain/models/notification_model.dart';
import 'package:decorizer/shared_features/notifications/domain/params/get_notifications_params.dart';
import 'package:decorizer/shared_features/notifications/domain/repositories/notifications_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsRepository)
class NotificaionsRepositoryImpl extends NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificaionsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications(
      GetNotificationsParams params) async {
    return remoteDataSource.getNotifications(params).mapError(
          (json) => notificationsFromJson(json['data']),
        );
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    return remoteDataSource
        .getUnreadCount()
        .mapError((json) => json['counter'] as int);
  }

  @override
  Future<Either<Failure, Unit>> markAsRead() async {
    return remoteDataSource.markAsRead().mapError((json) => unit);
  }
}
