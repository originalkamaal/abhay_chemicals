part of 'careof_bloc.dart';

abstract class UsersCareofState extends Equatable {
  const UsersCareofState();

  @override
  List<Object> get props => [];
}

class UsersCareofLoading extends UsersCareofState {}

class UsersCareofLoaded extends UsersCareofState {
  final QuerySnapshot<Map<String, dynamic>>? usersCareof;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const UsersCareofLoaded(
      {this.usersCareof,
      this.limit = 10,
      this.hasMore = true,
      this.pageNumber = 1});

  @override
  List<Object> get props => [usersCareof!, limit];
}
