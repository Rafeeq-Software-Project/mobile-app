import 'package:dio/dio.dart';
import 'package:rafeeq_app/core/di/service_locator.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/logic/token_manager.dart';
import '../constants/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory();

  Future<Dio> createDio() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final tokenManager = getIt<TokenManager>();
          final token = await tokenManager.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          final tokenManager = getIt<TokenManager>();
          if (e.response?.statusCode == 401) {
            final refreshed = await tokenManager.refreshToken();

            if (refreshed) {
              final newToken = await tokenManager.getAccessToken();
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';

              final clonedRequest = await dio.fetch(e.requestOptions);
              return handler.resolve(clonedRequest);
            }
          }
          return handler.next(e);
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    );

    return dio;
  }
}
