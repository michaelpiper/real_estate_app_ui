import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/messaging/domain/entities/message_entity.dart';
import 'package:result_library/result_library.dart';

abstract class ChatRepository {
  Future<Result<List<MessageEntity>, Failure>> getMessages(String chatId);
  Future<Result<void, Failure>> sendMessage({
    required String chatId,
    required String content,
  });
}
