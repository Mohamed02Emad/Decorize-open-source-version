import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/chat/domain/params/get_chats_params.dart';
import 'package:decorizer/shared_features/chat/domain/models/chat_model.dart';
import 'package:injectable/injectable.dart';

import '../repositories/chat_repository.dart';
@Injectable()
class GetChatsUseCase {
  final ChatRepository chatRepository;

  GetChatsUseCase({required this.chatRepository});

  Future<Either<Failure,List<ChatModel>>> call(GetChatsParams params) async {
    return await chatRepository.getChats(params);
  }
}
