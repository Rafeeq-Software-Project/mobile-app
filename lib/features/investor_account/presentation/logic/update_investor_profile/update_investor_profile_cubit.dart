import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/investor_account/data/models/update_investor_profile/update_investor_profile_request.dart';
import 'package:rafeeq_app/features/investor_account/data/repos/update_investor_profile_repo.dart';
import 'update_investor_profile_state.dart';

class UpdateInvestorProfileCubit extends Cubit<UpdateInvestorProfileState> {
  final UpdateInvestorProfileRepo repo;

  UpdateInvestorProfileCubit(this.repo)
    : super(const UpdateInvestorProfileState.initial());

  Future<void> updateInvestorProfile(
    UpdateInvestorProfileRequest request,
  ) async {
    emit(const UpdateInvestorProfileState.loading());

    final result = await repo.updateInvestorProfile(request);

    result.when(
      success: (data) {
        emit(UpdateInvestorProfileState.success(data));
      },
      failure: (error) {
        emit(UpdateInvestorProfileState.error(error.toString()));
      },
    );
  }
}
