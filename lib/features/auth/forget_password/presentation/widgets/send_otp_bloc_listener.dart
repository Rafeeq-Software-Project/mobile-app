// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:rafeeq_app/core/common/widgets/custom_alert_dialog.dart';
// import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
// import 'package:rafeeq_app/core/routing/routes.dart';
// import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/cubit/send_otp_cubit.dart';
// import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/cubit/send_otp_state.dart';

// class SendOtpBlocListener extends StatelessWidget {
//   const SendOtpBlocListener({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SendOtpCubit, SendOtpState>(
//       listener: (context, state) {
//         state.whenOrNull(
//           loading: () {
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (_) => const Center(child: CustomLoading(size: 100)),
//             );
//           },
//           success: (email) {

//             context.push(Routes., extra: email);
//           },
//           failure: (error) {
//             _showErrorDialog(context, error);
//           },
//         );
//       },
//     );
//   }

//   void _showErrorDialog(BuildContext context, String error) {
//     showDialog(
//       context: context,
//       builder: (context) => CustomAlertDialog(
//         dialogColor: Colors.redAccent,
//         dialogHeader: 'Send OTP Failed',
//         dialogBody: error,
//         dialogIcon: Icons.error,
//         press: () => context.pop(),
//       ),
//     );
//   }
// }
