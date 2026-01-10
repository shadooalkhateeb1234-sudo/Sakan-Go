import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/admin_upgrade_entity.dart';

abstract class AdminUpgradeRepository
{
  Future<Either<Failure, AdminUpgradeEntity>> checkAdminUpgrade();

  Future<Either<Failure, Unit>> submitUpgrade();
}