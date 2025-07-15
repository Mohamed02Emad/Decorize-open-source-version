import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/chat/domain/models/message_model.dart';
import 'package:decorizer/shared_features/chat/domain/params/get_messages_params.dart';
import 'package:injectable/injectable.dart';

import '../repositories/chat_repository.dart';
@Injectable()
class GetMessagesUseCase {
  final ChatRepository chatRepository;

  GetMessagesUseCase({required this.chatRepository});

  Future<Either<Failure,List<MessageModel>>> call(GetMessagesParams params) async {
    return await chatRepository.getMessages(params);
  }
}
