import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/chat/domain/repositories/chat_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetUnreadMessageCountUsecase extends UseCase<int, NoParams> {
  final ChatRepository chatRepository;

  GetUnreadMessageCountUsecase({required this.chatRepository});

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return chatRepository.getUnreadMessageCount();
  }
}
