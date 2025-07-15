import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/chat/domain/models/message_model.dart';
import 'package:injectable/injectable.dart';

import '../params/send_message_params.dart';
import '../repositories/chat_repository.dart';

@Injectable()
class SendMessageUseCase {
  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  Future<Either<Failure, MessageModel>> call(SendMessageParams params) async {
    return await _chatRepository.sendMessage(params);
  }
}
