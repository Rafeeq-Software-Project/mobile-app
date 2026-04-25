import 'package:dio/dio.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/network/network_failure.dart';
import 'package:rafeeq_app/features/chatbot/data/models/chatbot_message_model.dart';

class ChatbotRepo {
  final Dio _dio;

  ChatbotRepo(this._dio);

  Future<ApiResult<ChatbotResponse>> sendMessage(String input) async {
    try {
      final response = await _dio.post(
        'https://sohilaihab-rafeeq-api.hf.space/rafeeq/invoke',
        data: ChatbotRequest(input: input).toJson(),
      );

      final data = response.data;
      String outputText;
      if (data['output'] is Map) {
        outputText = data['output']['output']?.toString() ?? '';
      } else {
        outputText = data['output']?.toString() ?? '';
      }

      return ApiResult.success(ChatbotResponse(output: outputText));
    } on DioException catch (e) {
      return ApiResult.failure(
        NetworkFailure.unknown(e.message ?? 'Something went wrong'),
      );
    } catch (e) {
      return ApiResult.failure(NetworkFailure.unknown(e.toString()));
    }
  }
}
