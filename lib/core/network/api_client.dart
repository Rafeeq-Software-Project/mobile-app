import 'package:dio/dio.dart';
import 'package:rafeeq_app/core/constants/api_constants.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/otp/otp_request_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/otp/otp_response_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/reset_password/reset_password_request_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/reset_password/reset_password_response_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/verify_otp/verify_otp_request_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/verify_otp/verify_otp_response_model.dart';
import 'package:rafeeq_app/features/auth/login/data/models/login_request_model.dart';
import 'package:rafeeq_app/features/auth/login/data/models/login_response_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/refresh_token_request_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/refresh_token_response_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_request_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_response_model.dart';
import 'package:rafeeq_app/features/founder_account/data/models/founder_profile.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_model.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_picture/upload/upload_investor_profile_picture_response.dart';
import 'package:rafeeq_app/features/investor_account/data/models/update_investor_profile/update_investor_profile_request.dart';
import 'package:rafeeq_app/features/investor_account/data/models/update_investor_profile/update_investor_profile_response.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel body);

  @POST(ApiConstants.register)
  Future<RegisterResponseModel> register(@Body() RegisterRequestModel body);

  @POST(ApiConstants.forgotPassword)
  Future<OtpResponseModel> forgotPassword(@Body() OtpRequestModel body);

  @POST(ApiConstants.verifyOtp)
  Future<VerifyOtpResponseModel> verifyOtp(@Body() VerifyOtpRequestModel body);

  @POST(ApiConstants.resendOtp)
  Future<OtpResponseModel> resendOtp(@Body() OtpRequestModel body);

  @POST(ApiConstants.resetPassword)
  Future<ResetPasswordResponseModel> resetPassword(
    @Body() ResetPasswordRequestModel body,
  );

  @POST(ApiConstants.refreshToken)
  Future<RefreshTokenResponseModel> refreshToken(
    @Body() RefreshTokenRequest body,
  );

  @GET(ApiConstants.founderProfile)
  Future<FounderProfile> getMyFounderProfile();

  @GET(ApiConstants.investorProfile)
  Future<InvestorProfileModel> getMyInvestorProfile();

  @POST(ApiConstants.uploadInvestorProfile)
  @MultiPart()
  Future<UploadInvestorProfilePictureResponse> uploadInvestorProfilePicture(
    @Part(name: "file") MultipartFile file,
  );

  @POST(ApiConstants.updateInvestorProfile)
  Future<UpdateInvestorProfileResponse> updateInvestorProfile(
    @Body() UpdateInvestorProfileRequest request,
  );
}
