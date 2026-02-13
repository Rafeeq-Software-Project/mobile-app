import 'package:json_annotation/json_annotation.dart';
part 'reset_password_request_model.g.dart';

@JsonSerializable()
class ResetPasswordRequestModel {
  final String resetToken;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequestModel({
    required this.resetToken,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestModelToJson(this);
}
