import '../../../../user_session/domain/entities/user_session_entity.dart';
import '../../../domain/entities/admin_approval_entity.dart';

class AdminApprovalModel extends AdminApprovalEntity
{
  const AdminApprovalModel
  ({
    required super.userStatus,
    required super.rejectedReason,
    super.token,
  });

  factory AdminApprovalModel.fromJson(Map<String, dynamic> json)
  {
    return AdminApprovalModel
    (
      userStatus: UserStatus.values.firstWhere
      (
        (e) => e.name == json['user_status'],
      ),
      rejectedReason: List<String>.from(json['rejected_reason']),
      token: json['token']
    );
  }

  @override
  List<Object?> get props => [ super.userStatus, super.rejectedReason, super.token ];
}