import 'package:equatable/equatable.dart';

import '../../domain/entities/admin_upgrade_entity.dart';

abstract class AdminUpgradeState extends Equatable
{
  @override
  List<Object?> get props => [];
}

class AdminUpgradeInitial extends AdminUpgradeState {}

class AdminUpgradeLoading extends AdminUpgradeState {}

class AdminUpgradeLoaded extends AdminUpgradeState
{
  final AdminUpgradeEntity adminUpgradeEntity;
  AdminUpgradeLoaded({required this.adminUpgradeEntity});
}

class AdminUpgradeSubmitted extends AdminUpgradeState {}

class AdminUpgradeError extends AdminUpgradeState
{
  final String message;
  AdminUpgradeError({required this.message});
}