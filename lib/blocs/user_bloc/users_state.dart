part of 'user_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final QuerySnapshot<Map<String, dynamic>>? users;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const UsersLoaded(
      {this.users, this.limit = 10, this.hasMore = true, this.pageNumber = 1});

  @override
  List<Object> get props => [users!, limit];
}
