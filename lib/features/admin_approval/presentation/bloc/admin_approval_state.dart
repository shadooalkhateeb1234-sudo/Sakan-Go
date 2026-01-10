import 'package:equatable/equatable.dart';

import '../../domain/entities/admin_approval_entity.dart';

abstract class AdminApprovalState extends Equatable
{
  @override
  List<Object?> get props => [];
}

class AdminApprovalInitial extends AdminApprovalState {}

class AdminApprovalLoading extends AdminApprovalState {}

class AdminApprovalLoaded extends AdminApprovalState
{
  final AdminApprovalEntity adminApprovalEntity;
  AdminApprovalLoaded({required this.adminApprovalEntity});
}

class AdminApprovalError extends AdminApprovalState
{
  final String message;
  AdminApprovalError({required this.message});
}