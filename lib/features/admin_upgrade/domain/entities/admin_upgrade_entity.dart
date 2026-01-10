import 'package:equatable/equatable.dart';

enum UpgradeStatus { approved, pending, rejected }

class AdminUpgradeEntity extends Equatable
{
  final UpgradeStatus upgradeStatus;
  final List<String> rejectedReason;

  const AdminUpgradeEntity({required this.upgradeStatus, required this.rejectedReason});

  @override
  List<Object?> get props => [upgradeStatus, rejectedReason];
}