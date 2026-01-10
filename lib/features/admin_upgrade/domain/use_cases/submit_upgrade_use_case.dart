import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/admin_upgrade_repository.dart';


class SubmitUpgradeUseCase
{
  final AdminUpgradeRepository adminUpgradeRepository;

  SubmitUpgradeUseCase({required this.adminUpgradeRepository});

  Future<Either<Failure, Unit>> call() async
  {
    return await adminUpgradeRepository.submitUpgrade();
  }
}