import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/features/investor_account/data/repos/upload_investor_picture_repo.dart';
import 'upload_investor_profile_picture_state.dart';

class UploadInvestorProfilePictureCubit
    extends Cubit<UploadInvestorProfilePictureState> {
  final UploadInvestorPictureRepo repository;

  UploadInvestorProfilePictureCubit(this.repository)
    : super(const UploadInvestorProfilePictureState.initial());

  Future<void> uploadPicture(File image) async {
    emit(const UploadInvestorProfilePictureState.loading());

    try {
      final response = await repository.uploadInvestorProfilePicture(image);

      emit(UploadInvestorProfilePictureState.success(response));
    } catch (e) {
      emit(UploadInvestorProfilePictureState.error(e.toString()));
    }
  }
}
