import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/founder_account/data/models/founder_profile.dart';
import 'package:rafeeq_app/features/founder_account/data/repos/get_my_founder_profile_repo.dart';
import 'founder_profile_state.dart';

class FounderProfileCubit extends Cubit<FounderProfileState> {
  final GetMyFounderProfileRepo repository;

  FounderProfileCubit(this.repository)
    : super(const FounderProfileState.initial());

  Future<void> fetchFounderProfile() async {
    emit(const FounderProfileState.loading());

    final result = await repository.getFounderProfile();

    result.when(
      success: (FounderProfile profile) {
        emit(FounderProfileState.loaded(profile: profile));
      },
      failure: (message) {
        emit(FounderProfileState.error(message: message.toString()));
      },
    );
  }
}
