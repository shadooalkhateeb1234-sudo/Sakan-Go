import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../user_session/domain/entities/user_session_entity.dart';
import '../widgets/approval_status_card.dart';
import '../bloc/admin_approval_state.dart';
import '../bloc/admin_approval_bloc.dart';

class AdminApprovalPage extends StatelessWidget
{
  const AdminApprovalPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: SafeArea
      (
        child: Center
        (
          child: BlocBuilder<AdminApprovalBloc, AdminApprovalState>
          (
            builder: (context, state)
            {

              if (state is AdminApprovalLoading)
              {
                return ApprovalStatusCard
                (
                  iconPath: 'assets/icons/upload.svg',
                  backgroundSvg: 'assets/backgrounds/loading_bg.svg',
                  title: 'LOADING',
                  subtitle: 'loading',
                  isLoading: true
                );
              }

              if (state is AdminApprovalLoaded)
              {
                final status = state.adminApprovalEntity.userStatus;

                switch (status)
                {
                  case UserStatus.pending:
                    return ApprovalStatusCard
                    (
                      iconPath: 'assets/icons/pending.svg',
                      backgroundSvg: 'assets/backgrounds/pending_bg.svg',
                      title: 'PENDING',
                      subtitle: 'pending',
                      actionButton: ElevatedButton
                      (
                        onPressed: () {},
                        child: const Text('ok')
                      )
                    );

                  case UserStatus.rejected:
                    return ApprovalStatusCard
                    (
                      iconPath: 'assets/icons/rejected.svg',
                      backgroundSvg: 'assets/backgrounds/error_bg.svg',
                      title: 'REJECTED',
                      subtitle: 'rejected',
                      actionButton: ElevatedButton
                      (
                        onPressed: ()
                        {
                          // GoRouter → Complete Profile
                        },
                        child: const Text('REVIEW PROFILE')
                      )
                    );

                  case UserStatus.approved:
                    return ApprovalStatusCard
                    (
                      iconPath: 'assets/icons/success.svg',
                      backgroundSvg: 'assets/backgrounds/success_bg.svg',
                      title: 'APPROVED',
                      subtitle: 'approved',
                      actionButton: ElevatedButton
                      (
                        onPressed: ()
                        {
                          // GoRouter → Home
                        },
                        child: const Text('GO TO HOME PAGE'),
                      ),
                    );
                  case UserStatus.newUser:
                    throw UnimplementedError();
                }
              }
              return const SizedBox.shrink();
            }
          )
        )
      )
    );
  }
}