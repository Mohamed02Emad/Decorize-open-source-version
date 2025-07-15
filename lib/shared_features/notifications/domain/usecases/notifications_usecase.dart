import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/notifications/domain/models/notification_model.dart';
import 'package:decorizer/shared_features/notifications/domain/params/get_notifications_params.dart';
import 'package:decorizer/shared_features/notifications/domain/repositories/notifications_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class NotificationsUsecase extends UseCase<List<NotificationModel>, GetNotificationsParams> {
  final NotificationsRepository notificationsRepository;

  NotificationsUsecase({required this.notificationsRepository});

  @override
  Future<Either<Failure, List<NotificationModel>>> call(GetNotificationsParams params) async {
    return notificationsRepository.getNotifications(params);
  }
}
