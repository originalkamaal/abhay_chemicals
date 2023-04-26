part of 'common_bloc.dart';

@immutable
abstract class CommonEvent {}

class BottomNavPageChange extends CommonEvent {
  final int pageNo;

  BottomNavPageChange(this.pageNo);
}
