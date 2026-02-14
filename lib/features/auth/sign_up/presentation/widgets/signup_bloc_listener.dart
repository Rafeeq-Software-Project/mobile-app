import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/custom_alert_dialog.dart';
import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
import 'package:rafeeq_app/core/helpers/role_navigation.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/logic/register_cubit/register_cubit.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/logic/register_cubit/register_state.dart';

class SignupBlocListener extends StatelessWidget {
  const SignupBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () => _showLoadingDialog(context),
          success: (response) {
            showSuccessDialog(context, response.roleId);
          },

          failure: (error) => _showErrorDialog(context, error),
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        dialogColor: Colors.redAccent,
        dialogHeader: 'Signup Failed',
        dialogBody: error,
        dialogIcon: Icons.error,
        press: () => context.pop(),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: context.customAppColors.primary500.withValues(alpha: 0.3),
      builder: (context) => Center(child: const CustomLoading(size: 100)),
    );
  }

  void showSuccessDialog(BuildContext context, int roleId) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        dialogColor: context.customAppColors.primary500,
        dialogHeader: 'Signup Successful',
        dialogBody:
            'Congratulations, you have signed up successfully!\nAn OTP has been sent to your email inbox. Please use it to verify your email.',
        dialogIcon: Icons.check_circle_rounded,
        press: () {
          context.pop();
          RoleNavigation.goByRole(context, roleId);
        },
      ),
    );
  }
}
