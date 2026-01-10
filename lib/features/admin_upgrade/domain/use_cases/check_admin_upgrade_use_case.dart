import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/admin_upgrade_entity.dart';
import '../repositories/admin_upgrade_repository.dart';

class CheckAdminUpgradeUseCase
{
  final AdminUpgradeRepository adminUpgradeRepository;

  CheckAdminUpgradeUseCase({required this.adminUpgradeRepository});

  Future<Either<Failure, AdminUpgradeEntity>> call() async
  {
    return await adminUpgradeRepository.checkAdminUpgrade();
  }
}