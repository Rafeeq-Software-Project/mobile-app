import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/custom_alert_dialog.dart';
import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
import 'package:rafeeq_app/core/helpers/role_navigation.dart';
import 'package:rafeeq_app/features/auth/login/presentation/logic/login_cubit/login_cubit.dart';
import 'package:rafeeq_app/features/auth/login/presentation/logic/login_cubit/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CustomLoading(size: 100)),
            );
          },
          success: (loginResponse) {
            _closeDialogIfOpen(context);
            RoleNavigation.goByRole(context, loginResponse.roleId);
          },
          failure: (error) {
            _closeDialogIfOpen(context);
            _showErrorDialog(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        dialogColor: Colors.redAccent,
        dialogHeader: 'Login Failed',
        dialogBody: error,
        dialogIcon: Icons.error,
        press: () => context.pop(),
      ),
    );
  }

  void _closeDialogIfOpen(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
