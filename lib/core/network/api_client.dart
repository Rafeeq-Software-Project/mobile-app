import 'package:dio/dio.dart';
import 'package:rafeeq_app/core/constants/api_constants.dart';
import 'package:rafeeq_app/features/auth/login/data/models/login_request_model.dart';
import 'package:rafeeq_app/features/auth/login/data/models/login_response_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_request_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel body);

  @POST(ApiConstants.register)
  Future<RegisterResponseModel> register(@Body() RegisterRequestModel body);
}
