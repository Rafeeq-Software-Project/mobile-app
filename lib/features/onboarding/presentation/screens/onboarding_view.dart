import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
import 'package:rafeeq_app/core/utils/app_animations.dart';
import 'package:rafeeq_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:rafeeq_app/features/onboarding/presentation/logic/cubit/onboarding_cubit.dart';
import 'package:rafeeq_app/features/onboarding/presentation/logic/cubit/onboarding_state.dart';
import 'package:rafeeq_app/features/onboarding/presentation/screens/onboarding_screen.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return state.when(
          initial: () => const CustomLoading(
            size: 100,
            loadingAnimation: AppAnimations.animationsCircleLoading,
          ),
          onboardingCompleted: () => const LoginScreen(),
          onboardingUnCompleted: () => const OnboardingScreen(),
        );
      },
    );
  }
}
