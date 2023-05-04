part of 'careof_bloc.dart';

abstract class UsersCareofEvent extends Equatable {
  const UsersCareofEvent();

  @override
  List<Object> get props => [];
}

class LoadUsersCareof extends UsersCareofEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final String direction;
  final int pageNumber;

  const LoadUsersCareof(
      {this.lastDoc,
      this.limit = 10,
      this.direction = "init",
      this.pageNumber = 1});
}

class UpdateUsersCareof extends UsersCareofEvent {
  final QuerySnapshot<Map<String, dynamic>>? usersCareof;
  final int? pageNumber;
  final int? limit;

  const UpdateUsersCareof({
    this.usersCareof,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
