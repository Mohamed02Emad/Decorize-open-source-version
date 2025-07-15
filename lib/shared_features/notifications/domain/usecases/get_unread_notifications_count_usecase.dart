import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/notifications/domain/repositories/notifications_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetUnreadNotificationsCountUsecase extends UseCase<int, NoParams> {
  final NotificationsRepository notificationsRepository;

  GetUnreadNotificationsCountUsecase({required this.notificationsRepository});

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return notificationsRepository.getUnreadCount();
  }
}
