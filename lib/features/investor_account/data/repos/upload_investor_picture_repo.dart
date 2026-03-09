import 'dart:io';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_picture/upload/upload_investor_profile_picture_response.dart';

class UploadInvestorPictureRepo {
  final ApiClient apiService;

  UploadInvestorPictureRepo(this.apiService);

  Future<UploadInvestorProfilePictureResponse> uploadInvestorProfilePicture(
    File image,
  ) async {
    final multipartFile = await MultipartFile.fromFile(
      image.path,
      filename: image.path.split('/').last,
    );

    return await apiService.uploadInvestorProfilePicture(multipartFile);
  }
}
