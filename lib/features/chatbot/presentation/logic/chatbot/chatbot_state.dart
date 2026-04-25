import 'package:rafeeq_app/features/chatbot/data/models/chatbot_message_model.dart';

class ChatbotState {
  final List<ChatMessage> messages;
  final bool isTyping;
  final String? error;

  const ChatbotState({
    this.messages = const [],
    this.isTyping = false,
    this.error,
  });

  ChatbotState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
    String? error,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      error: error,
    );
  }
}
