import 'package:flutter_bloc/flutter_bloc.dart';
part 'nav_bar_founder_state.dart';

class NavBarFounderCubit extends Cubit<NavBarFouderState> {
  NavBarFounderCubit() : super(NavBarInitial());
  int selectIndex = 0;
  void changeCurrentIndex(int index) {
    selectIndex = index;
    emit(IndexChanged());
  }
}
