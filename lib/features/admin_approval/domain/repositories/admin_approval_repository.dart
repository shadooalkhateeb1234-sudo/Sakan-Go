import 'package:dartz/dartz.dart';

import 'package:sakan_go_mobile_app/features/admin_approval/domain/entities/admin_approval_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class AdminApprovalRepository
{
  Future<Either<Failure, AdminApprovalEntity>> checkAdminApproval();
}