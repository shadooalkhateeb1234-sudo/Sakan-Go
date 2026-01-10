import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/admin_approval_entity.dart';

abstract class AdminApprovalRepository
{
  Future<Either<Failure, AdminApprovalEntity>> checkAdminApproval();
}