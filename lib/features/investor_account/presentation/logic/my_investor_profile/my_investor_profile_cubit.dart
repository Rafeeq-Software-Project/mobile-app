import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_model.dart';
import 'package:rafeeq_app/features/investor_account/data/repos/get_my_investor_profile_repo.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/my_investor_profile/my_investor_profile_state.dart';

class MyInvestorProfileCubit extends Cubit<MyInvestorProfileState> {
  MyInvestorProfileCubit(this.repo) : super(MyInvestorProfileState.initial());
  final GetMyInvestorProfileRepo repo;

  Future<void> fetchInvestorProfile() async {
    emit(const MyInvestorProfileState.loading());

    final result = await repo.getInvestorProfile();

    result.when(
      success: (InvestorProfileModel profile) {
        emit(MyInvestorProfileState.loaded(profile: profile));
      },
      failure: (message) {
        emit(MyInvestorProfileState.error(message: message.toString()));
      },
    );
  }
}
