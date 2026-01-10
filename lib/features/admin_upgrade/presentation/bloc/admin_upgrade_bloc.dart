import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:sakan_go_mobile_app/features/admin_upgrade/domain/use_cases/submit_upgrade_use_case.dart';
import '../../domain/use_cases/check_admin_upgrade_use_case.dart';
import 'admin_upgrade_event.dart';
import 'admin_upgrade_state.dart';

class AdminUpgradeBloc extends Bloc<AdminUpgradeEvent, AdminUpgradeState>
{
  final CheckAdminUpgradeUseCase checkAdminUpgradeUseCase;
  final SubmitUpgradeUseCase submitUpgradeUseCase;
  Timer? _timer;

  AdminUpgradeBloc({required this.checkAdminUpgradeUseCase, required this.submitUpgradeUseCase}) : super(AdminUpgradeInitial())
  {
    on<CheckAdminUpgradeEvent>(_onCheckUpgrade);
    on<SubmitUpgradeEvent>(_onSubmitUpgrade);
    on<StartPollingEvent>(_onStartPolling);
    on<StopPollingEvent>(_onStopPolling);
  }

  Future<void> _onCheckUpgrade(CheckAdminUpgradeEvent event, Emitter<AdminUpgradeState> emit) async
  {
    if (event.isShowLoading)
    {
      emit(AdminUpgradeLoading());
    }

    final result = await checkAdminUpgradeUseCase();
    result.fold
    (
      (failure)
      {
        emit(AdminUpgradeError(message: "some thing went wrong"));
      },
      (approval)
      {
        print("user status: ${approval.upgradeStatus}");
        emit(AdminUpgradeLoaded(adminUpgradeEntity: approval));
      }
    );
  }

  Future<void> _onSubmitUpgrade(SubmitUpgradeEvent event, Emitter<AdminUpgradeState> emit) async
  {
    emit(AdminUpgradeLoading());

    final result = await submitUpgradeUseCase();

    result.fold
    (
      (failure)
      {
        emit(AdminUpgradeError(message: 'Failed to submit upgrade request'));
      },
      (_)
      {
        emit(AdminUpgradeSubmitted());
        add(StartPollingEvent());
      }
    );
  }

  void _onStartPolling(StartPollingEvent event, Emitter<AdminUpgradeState> emit)
  {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => add(CheckAdminUpgradeEvent()));
  }

  void _onStopPolling(StopPollingEvent event, Emitter<AdminUpgradeState> emit)
  {
    _timer?.cancel();
  }

  @override
  Future<void> close()
  {
    _timer?.cancel();
    return super.close();
  }
}