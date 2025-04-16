import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/features/messaging/domain/repositories/chat_repository.dart';
import 'package:result_library/result_library.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage({required this.repository});
  Future<Result<void, Failure>> call(
      {required String chatId, required String content}) {
    return repository.sendMessage(chatId: chatId, content: content);
  }
}
