import 'package:equatable/equatable.dart';

import '../../../user_session/domain/entities/user_session_entity.dart';

class AdminApprovalEntity extends Equatable
{
  final UserStatus userStatus;
  final List<String> rejectedReason;
  final String? token;

  const AdminApprovalEntity
  ({
    required this.userStatus,
    required this.rejectedReason,
    this.token,
  });

  @override
  List<Object?> get props => [userStatus, rejectedReason, token];
}