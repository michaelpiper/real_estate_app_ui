// lib/features/chat/presentation/bloc/chat_event.dart
part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadMessages extends ChatEvent {
  final String chatId;

  const LoadMessages({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String content;

  const SendMessageEvent({
    required this.chatId,
    required this.content,
  });

  @override
  List<Object> get props => [chatId, content];
}
