import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/messaging/domain/entities/message_entity.dart';
import 'package:real_estate_app/features/messaging/domain/repositories/chat_repository.dart';
import 'package:result_library/result_library.dart';

class GetChatMessages {
  final ChatRepository repository;

  GetChatMessages({required this.repository});
  Future<Result<List<MessageEntity>, Failure>> call(String chatId) {
    return repository.getMessages(chatId);
  }
}
