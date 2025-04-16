part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;

  const ChatLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatError extends ChatState {
  final String message;

  const ChatError({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageSent extends ChatState {
  final MessageEntity message;

  const MessageSent({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageSendingError extends ChatState {
  final String message;

  const MessageSendingError({required this.message});

  @override
  List<Object> get props => [message];
}
