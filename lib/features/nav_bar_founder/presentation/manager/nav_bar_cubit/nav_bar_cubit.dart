import 'package:flutter_bloc/flutter_bloc.dart';
part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());
  int selectIndex = 0;
  void changeCurrentIndex(int index) {
    selectIndex = index;
    emit(IndexChanged());
  }
}
