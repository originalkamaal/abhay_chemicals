part of 'common_bloc.dart';

class CommonState {
  final int pageNo;

  CommonState({this.pageNo = 0});

  CommonState copyWith({int? pageNo}) {
    return CommonState(pageNo: pageNo ?? this.pageNo);
  }
}
