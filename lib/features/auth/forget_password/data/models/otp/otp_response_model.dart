import 'package:json_annotation/json_annotation.dart';
part 'otp_response_model.g.dart';

@JsonSerializable()
class OtpResponseModel {
  @JsonKey(name: "message")
  final String otpCode;

  OtpResponseModel({required this.otpCode});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpResponseModelToJson(this);
}
