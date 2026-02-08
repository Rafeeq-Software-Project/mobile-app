import 'package:flutter_bloc/flutter_bloc.dart';

import 'nav_bar_investor_state.dart';

class NavBarInvestorCubit extends Cubit<NavBarInvestorState> {
  NavBarInvestorCubit() : super(NavBarInvestorInitial());
  int selectIndex = 0;
  void changeCurrentIndex(int index) {
    selectIndex = index;
    emit(IndexChanged());
  }
}
