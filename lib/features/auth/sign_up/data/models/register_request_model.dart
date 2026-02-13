import 'package:json_annotation/json_annotation.dart';

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String username;
  final int roleId;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.roleId,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
