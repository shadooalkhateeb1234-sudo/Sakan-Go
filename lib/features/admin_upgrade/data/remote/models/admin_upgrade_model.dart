import '../../../domain/entities/admin_upgrade_entity.dart';

class AdminUpgradeModel extends AdminUpgradeEntity
{
  const AdminUpgradeModel({required super.upgradeStatus, required super.rejectedReason});

  factory AdminUpgradeModel.fromJson(Map<String, dynamic> json)
  {
    return AdminUpgradeModel
    (
       upgradeStatus: UpgradeStatus.values.firstWhere
       (
         (e) => e.name == json['request_status'],
       ),
       rejectedReason: List<String>.from(json['request_rejected_reason']),
    );
  }

  @override
  List<Object?> get props => [ super.upgradeStatus, super.rejectedReason];
}