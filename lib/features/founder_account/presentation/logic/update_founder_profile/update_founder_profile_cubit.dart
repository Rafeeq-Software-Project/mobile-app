import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/founder_account/data/models/update_founder_profile/update_founder_profile_request.dart';
import 'package:rafeeq_app/features/founder_account/data/repos/update_founder_profile_repo.dart';
import 'package:rafeeq_app/features/founder_account/presentation/logic/update_founder_profile/update_founder_profile_state.dart';

class UpdateFounderProfileCubit extends Cubit<UpdateFounderProfileState> {
  UpdateFounderProfileCubit(this.repo)
    : super(UpdateFounderProfileState.initial());
  final UpdateFounderProfileRepo repo;

  Future<void> updateInvestorProfile(
    UpdateFounderProfileRequest request,
  ) async {
    emit(const UpdateFounderProfileState.loading());
    final result = await repo.updateFounderProfile(request);
    result.when(
      success: (data) {
        emit(UpdateFounderProfileState.loaded(data));
      },
      failure: (error) {
        emit(UpdateFounderProfileState.error(error));
      },
    );
  }
}
