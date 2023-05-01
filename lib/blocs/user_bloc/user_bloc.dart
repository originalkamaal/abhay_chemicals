import 'dart:async';

import 'package:abhay_chemicals/controllers/users_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_state.dart';
part 'users_event.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersController _usersController;
  StreamSubscription? _productSubscription;

  UsersBloc({required UsersController usersController})
      : _usersController = usersController,
        super(UsersLoading()) {
    on<LoadUsers>(_mapLoadUsersToState);
    on<UpdateUsers>(_mapUpdateUsersToState);
    // on<LoadNextUsers>(_mapLoadNextUsersToState);
  }

  _mapLoadUsersToState(LoadUsers event, Emitter<UsersState> emit) async {
    _productSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _productSubscription = _usersController
          .getAllUsers(limit: limit, action: event.direction)
          .listen((users) {
        add(UpdateUsers(users: users, pageNumber: 1, limit: limit));
      });
    } else {
      print("Last doc is there");
      _productSubscription = _usersController
          .getAllUsers(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((users) {
        add(UpdateUsers(
            users: users,
            pageNumber: event.direction == "forward"
                ? event.pageNumber + 1
                : event.direction == "back"
                    ? event.pageNumber - 1
                    : event.pageNumber,
            limit: event.limit));
      });
    }
  }

  _mapUpdateUsersToState(UpdateUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoaded(
        users: event.users,
        hasMore: (event.users!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }
}
