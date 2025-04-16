import 'package:real_estate_app/features/messaging/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.senderId,
    required super.content,
    required super.timestamp,
  });
}
