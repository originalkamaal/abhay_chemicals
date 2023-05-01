part of 'common_bloc.dart';

abstract class CommonEvent {}

class BottomNavPageChange extends CommonEvent {
  final int pageNo;

  BottomNavPageChange(this.pageNo);
}

class OpenBottomSheet extends CommonEvent {
  final bool isBtmOpen;
  OpenBottomSheet(this.isBtmOpen);
}
