import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/chat/domain/models/chat_model.dart';
import 'package:injectable/injectable.dart';

import '../params/create_chat_params.dart';
import '../repositories/chat_repository.dart';

@Injectable()
class CreateChatUseCase {
  final ChatRepository _chatRepository;

  CreateChatUseCase(this._chatRepository);

  Future<Either<Failure, ChatModel>> call(CreateChatParams params) async {
    return await _chatRepository.createChat(params);
  }
}
