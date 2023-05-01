part of 'common_bloc.dart';

class CommonState {
  final int pageNo;
  final bool isBtmOpen;

  CommonState({this.pageNo = 0, this.isBtmOpen = false});

  CommonState copyWith({int? pageNo, bool? isBtmOpen}) {
    return CommonState(
        pageNo: pageNo ?? this.pageNo, isBtmOpen: isBtmOpen ?? this.isBtmOpen);
  }
}
