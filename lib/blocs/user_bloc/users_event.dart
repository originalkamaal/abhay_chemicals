part of 'user_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UsersEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final int direction;
  final int pageNumber;

  LoadUsers(
      {this.lastDoc, this.limit = 3, this.direction = 1, this.pageNumber = 1});
}

class UpdateUsers extends UsersEvent {
  final QuerySnapshot<Map<String, dynamic>>? users;
  final int? pageNumber;
  final int? limit;

  UpdateUsers({
    this.users,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
