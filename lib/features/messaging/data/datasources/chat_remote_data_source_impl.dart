import 'package:real_estate_app/features/messaging/data/models/message.dart';
import 'package:real_estate_app/features/messaging/domain/datasources/chat_remote_data_source.dart';

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  ChatRemoteDataSourceImpl({required client});

  @override
  Future<List<MessageModel>> getMessages(String chatId) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage({required String chatId, required String content}) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
