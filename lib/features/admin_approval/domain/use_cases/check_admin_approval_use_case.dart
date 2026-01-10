import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/admin_approval_entity.dart';
import '../repositories/admin_approval_repository.dart';

class CheckAdminApprovalUseCase
{
  final AdminApprovalRepository adminApprovalRepository;

  CheckAdminApprovalUseCase({required this.adminApprovalRepository});

  Future<Either<Failure, AdminApprovalEntity>> call() async
  {
    return await adminApprovalRepository.checkAdminApproval();
  }
}