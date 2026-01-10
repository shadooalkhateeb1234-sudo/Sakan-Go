import 'package:equatable/equatable.dart';

abstract class AdminUpgradeEvent extends Equatable
{
  @override
  List<Object?> get props => [];
}

class SubmitUpgradeEvent extends AdminUpgradeEvent {}

class CheckAdminUpgradeEvent extends AdminUpgradeEvent
{
  final bool isShowLoading;
  CheckAdminUpgradeEvent({this.isShowLoading = false});
}

class StartPollingEvent extends AdminUpgradeEvent {}

class StopPollingEvent extends AdminUpgradeEvent {}