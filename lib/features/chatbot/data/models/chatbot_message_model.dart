import 'package:json_annotation/json_annotation.dart';
part 'chatbot_message_model.g.dart';

enum MessageRole { user, bot }

class ChatMessage {
  final String text;
  final MessageRole role;
  final DateTime timestamp;
  final bool isLoading;

  ChatMessage({
    required this.text,
    required this.role,
    required this.timestamp,
    this.isLoading = false,
  });

  ChatMessage copyWith({
    String? text,
    MessageRole? role,
    DateTime? timestamp,
    bool? isLoading,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@JsonSerializable()
class ChatbotRequest {
  final String input;

  ChatbotRequest({required this.input});

  factory ChatbotRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatbotRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChatbotRequestToJson(this);
}

@JsonSerializable()
class ChatbotResponse {
  final String output;

  ChatbotResponse({required this.output});

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatbotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatbotResponseToJson(this);
}
