import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate_app/features/messaging/domain/usecases/get_chat_messages.dart';
import 'package:real_estate_app/features/messaging/domain/usecases/send_message.dart';
import 'package:real_estate_app/features/messaging/domain/entities/message_entity.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatMessages getMessages;
  final SendMessage sendMessage;

  ChatBloc({
    required this.getMessages,
    required this.sendMessage,
  }) : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await getMessages(event.chatId);
    if (result.isErr()) {
      emit(ChatError(message: result.err().toString()));
      return;
    }
    emit(ChatLoaded(messages: result.ok()));
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is ChatLoaded) {
      // Optimistically add the message to the UI
      final newMessage = MessageEntity(
        id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
        senderId: 'current-user-id', // Replace with actual user ID
        content: event.content,
        timestamp: DateTime.now(),
        // isMe: true,
      );

      emit(ChatLoaded(
        messages: List.from(currentState.messages)..add(newMessage),
      ));

      // Send to server
      final result = await sendMessage(
        chatId: event.chatId,
        content: event.content,
      );
      if (result.isErr()) {
        // Revert optimistic update on failure
        emit(ChatLoaded(messages: currentState.messages));
        emit(MessageSendingError(message: result.err().toString()));
        return;
      }

      emit(MessageSent(message: newMessage));
      // Reload messages to get the actual message from server
      add(LoadMessages(chatId: event.chatId));
    }
  }
}
