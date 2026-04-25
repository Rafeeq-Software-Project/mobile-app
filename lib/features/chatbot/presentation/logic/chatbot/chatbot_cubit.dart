import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/chatbot/data/models/chatbot_message_model.dart';
import 'package:rafeeq_app/features/chatbot/data/repos/charbot_repo.dart';
import 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  final ChatbotRepo _repo;

  ChatbotCubit(this._repo) : super(const ChatbotState()) {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    emit(
      state.copyWith(
        messages: [
          ChatMessage(
            text:
                'Hi! I am Rafeeq, your AI assistant. How can I help you today?',
            role: MessageRole.bot,
            timestamp: DateTime.now(),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage(String input) async {
    if (input.trim().isEmpty) return;

    // Add user message
    final userMsg = ChatMessage(
      text: input.trim(),
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    emit(
      state.copyWith(
        messages: [...state.messages, userMsg],
        isTyping: true,
        error: null,
      ),
    );

    final result = await _repo.sendMessage(input.trim());

    result.when(
      success: (response) {
        final botMsg = ChatMessage(
          text: response.output,
          role: MessageRole.bot,
          timestamp: DateTime.now(),
        );
        emit(
          state.copyWith(
            messages: [...state.messages, botMsg],
            isTyping: false,
          ),
        );
      },
      failure: (error) {
        final errorMsg = ChatMessage(
          text: 'عذراً، حدث خطأ. يرجى المحاولة مجدداً.',
          role: MessageRole.bot,
          timestamp: DateTime.now(),
        );
        emit(
          state.copyWith(
            messages: [...state.messages, errorMsg],
            isTyping: false,
            error: error.toString(),
          ),
        );
      },
    );
  }

  void clearChat() {
    emit(const ChatbotState());
    _addWelcomeMessage();
  }
}
