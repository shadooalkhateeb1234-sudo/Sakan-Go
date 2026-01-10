import 'package:dartz/dartz.dart';

import 'package:sakan_go_mobile_app/features/admin_upgrade/domain/repositories/admin_upgrade_repository.dart';
import '../../../../core/errors/failures.dart';

class SubmitUpgradeUseCase
{
  final AdminUpgradeRepository adminUpgradeRepository;

  SubmitUpgradeUseCase({required this.adminUpgradeRepository});

  Future<Either<Failure, Unit>> call() async
  {
    return await adminUpgradeRepository.submitUpgrade();
  }
}