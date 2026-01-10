import 'package:dartz/dartz.dart';

import 'package:sakan_go_mobile_app/features/admin_upgrade/domain/repositories/admin_upgrade_repository.dart';
import 'package:sakan_go_mobile_app/features/admin_upgrade/domain/entities/admin_upgrade_entity.dart';
import '../../../../core/errors/failures.dart';

class CheckAdminUpgradeUseCase
{
  final AdminUpgradeRepository adminUpgradeRepository;

  CheckAdminUpgradeUseCase({required this.adminUpgradeRepository});

  Future<Either<Failure, AdminUpgradeEntity>> call() async
  {
    return await adminUpgradeRepository.checkAdminUpgrade();
  }
}