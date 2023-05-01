import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc() : super(CommonState()) {
    on<BottomNavPageChange>(_updateBottomNavPage);
    on<OpenBottomSheet>(_updateBottomSheetStatus);
  }

  FutureOr<void> _updateBottomNavPage(
      BottomNavPageChange event, Emitter<CommonState> emit) {
    emit(state.copyWith(pageNo: event.pageNo));
  }

  FutureOr<void> _updateBottomSheetStatus(
      OpenBottomSheet event, Emitter<CommonState> emit) {
    emit(state.copyWith(isBtmOpen: event.isBtmOpen));
  }
}
