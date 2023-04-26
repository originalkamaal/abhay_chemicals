import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc() : super(CommonState()) {
    on<BottomNavPageChange>(_updateBottomNavPage);
  }

  FutureOr<void> _updateBottomNavPage(
      BottomNavPageChange event, Emitter<CommonState> emit) {
    print("recieved ${event.pageNo}");

    emit(state.copyWith(pageNo: event.pageNo));
    print("updated ${event.pageNo}");
  }
}
