import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/notifications/domain/repositories/notifications_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class MarkNotificationsAsReadUsecase extends UseCase<Unit, NoParams> {
  final NotificationsRepository notificationsRepository;

  MarkNotificationsAsReadUsecase({required this.notificationsRepository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return notificationsRepository.markAsRead();
  }
}
