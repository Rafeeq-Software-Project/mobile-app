import 'package:json_annotation/json_annotation.dart';
part 'upload_investor_profile_picture_response.g.dart';

@JsonSerializable()
class UploadInvestorProfilePictureResponse {
  final String message;
  final String profilePictureUrl;

  UploadInvestorProfilePictureResponse({
    required this.message,
    required this.profilePictureUrl,
  });

  factory UploadInvestorProfilePictureResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$UploadInvestorProfilePictureResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UploadInvestorProfilePictureResponseToJson(this);
}
