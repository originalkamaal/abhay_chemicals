import 'dart:async';

import 'package:abhay_chemicals/controllers/careof_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'careof_state.dart';
part 'careof_event.dart';

class UsersCareofBloc extends Bloc<UsersCareofEvent, UsersCareofState> {
  final UsersCareofController _usersCareofController;
  StreamSubscription? _productSubscription;

  UsersCareofBloc({required UsersCareofController usersCareofController})
      : _usersCareofController = usersCareofController,
        super(UsersCareofLoading()) {
    on<LoadUsersCareof>(_mapLoadUsersCareofToState);
    on<UpdateUsersCareof>(_mapUpdateUsersCareofToState);
    // on<LoadNextUsersCareof>(_mapLoadNextUsersCareofToState);
  }

  _mapLoadUsersCareofToState(
      LoadUsersCareof event, Emitter<UsersCareofState> emit) async {
    _productSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _productSubscription = _usersCareofController
          .getAllUsersCareof(limit: limit, action: event.direction)
          .listen((usersCareof) {
        add(UpdateUsersCareof(
            usersCareof: usersCareof, pageNumber: 1, limit: limit));
      });
    } else {
      _productSubscription = _usersCareofController
          .getAllUsersCareof(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((usersCareof) {
        add(UpdateUsersCareof(
            usersCareof: usersCareof,
            pageNumber: event.direction == "forward"
                ? event.pageNumber + 1
                : event.direction == "back"
                    ? event.pageNumber - 1
                    : event.pageNumber,
            limit: event.limit));
      });
    }
  }

  _mapUpdateUsersCareofToState(
      UpdateUsersCareof event, Emitter<UsersCareofState> emit) async {
    emit(UsersCareofLoaded(
        usersCareof: event.usersCareof,
        hasMore: (event.usersCareof!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }
}
