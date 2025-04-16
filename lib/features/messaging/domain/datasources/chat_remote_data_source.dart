import 'package:real_estate_app/features/messaging/data/models/message.dart';

abstract class ChatRemoteDataSource {
  Future<List<MessageModel>> getMessages(String chatId);
  Future<void> sendMessage({
    required String chatId,
    required String content,
  });
}
