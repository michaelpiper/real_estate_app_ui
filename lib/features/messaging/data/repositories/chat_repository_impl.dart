// lib/features/chat/data/repositories/chat_repository_impl.dart
import 'package:real_estate_app/core/errors/failures.dart';
import 'package:real_estate_app/core/network/network_info.dart';
import 'package:real_estate_app/features/messaging/domain/datasources/chat_remote_data_source.dart';
import 'package:real_estate_app/features/messaging/domain/entities/message_entity.dart';
import 'package:real_estate_app/features/messaging/domain/repositories/chat_repository.dart';
import 'package:result_library/result_library.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<List<MessageEntity>, Failure>> getMessages(
      String chatId) async {
    if (await networkInfo.isConnected) {
      try {
        final messages = await remoteDataSource.getMessages(chatId);
        return Ok(messages);
      } catch (e) {
        return Err(ServerFailure(message: e.toString()));
      }
    } else {
      return Err(const NetworkFailure());
    }
  }

  @override
  Future<Result<void, Failure>> sendMessage({
    required String chatId,
    required String content,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.sendMessage(chatId: chatId, content: content);
        return Ok(null);
      } catch (e) {
        return Err(ServerFailure(message: e.toString()));
      }
    } else {
      return Err(const NetworkFailure());
    }
  }
}
