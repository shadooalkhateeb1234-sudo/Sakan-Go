import 'package:equatable/equatable.dart';

abstract class AdminApprovalEvent extends Equatable
{
  @override
  List<Object?> get props => [];
}

class CheckAdminApprovalEvent extends AdminApprovalEvent
{
  final bool isShowLoading;
  CheckAdminApprovalEvent({this.isShowLoading = false});
}

class StartPollingEvent extends AdminApprovalEvent {}

class StopPollingEvent extends AdminApprovalEvent {}