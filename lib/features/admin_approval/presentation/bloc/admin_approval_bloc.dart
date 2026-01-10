import 'package:bloc/bloc.dart';
import 'dart:async';

import '../../domain/use_cases/check_admin_approval_use_case.dart';
import 'admin_approval_event.dart';
import 'admin_approval_state.dart';

class AdminApprovalBloc extends Bloc<AdminApprovalEvent, AdminApprovalState>
{
  final CheckAdminApprovalUseCase checkAdminApprovalUseCase;
  Timer? _timer;

  AdminApprovalBloc({required this.checkAdminApprovalUseCase}) : super(AdminApprovalInitial())
  {
    on<CheckAdminApprovalEvent>(_onCheckApproval);
    on<StartPollingEvent>(_onStartPolling);
    on<StopPollingEvent>(_onStopPolling);
  }

  Future<void> _onCheckApproval(CheckAdminApprovalEvent event, Emitter<AdminApprovalState> emit) async
  {
    if (event.isShowLoading)
    {
      emit(AdminApprovalLoading());
    }

    final response = await checkAdminApprovalUseCase();
    response.fold
    (
      (failure)
      {
        emit(AdminApprovalError(message: "some thing"));
      },
      (approval)
      {
        print("user status: ${approval.userStatus}");
        emit(AdminApprovalLoaded(adminApprovalEntity: approval));
      }
    );
  }

  void _onStartPolling(StartPollingEvent event, Emitter<AdminApprovalState> emit)
  {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => add(CheckAdminApprovalEvent()));
  }

  void _onStopPolling(StopPollingEvent event, Emitter<AdminApprovalState> emit)
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