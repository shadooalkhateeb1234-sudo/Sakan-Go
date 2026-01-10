import 'package:dartz/dartz.dart';

import 'package:sakan_go_mobile_app/features/admin_approval/domain/entities/admin_approval_entity.dart';
import '../repositories/admin_approval_repository.dart';
import '../../../../core/errors/failures.dart';

class CheckAdminApprovalUseCase
{
  final AdminApprovalRepository adminApprovalRepository;

  CheckAdminApprovalUseCase({required this.adminApprovalRepository});

  Future<Either<Failure, AdminApprovalEntity>> call() async
  {
    return await adminApprovalRepository.checkAdminApproval();
  }
}