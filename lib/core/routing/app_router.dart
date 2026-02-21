import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/screens/popular_questions_screen.dart';
import 'package:rafeeq_app/core/common/screens/terms_and_condition_screen.dart';
import 'package:rafeeq_app/core/di/service_locator.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/resend_otp/resend_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/send_otp/send_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/screens/reset_password_screen.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/screens/verify_otp_screen.dart';
import 'package:rafeeq_app/features/auth/login/presentation/logic/login_cubit/login_cubit.dart';
import 'package:rafeeq_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/logic/register_cubit/register_cubit.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/screens/register_screen.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/screens/verification_screen.dart';
import 'package:rafeeq_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/create_project_coordinator.dart';
import 'package:rafeeq_app/features/founder_account/presentation/screens/founder_account_screen.dart';
import 'package:rafeeq_app/features/investor_account/presentation/screens/investor_account_screen.dart';
import 'package:rafeeq_app/features/investor_apply_project/presentation/screens/apply_to_project_screen.dart';
import 'package:rafeeq_app/features/investor_saved_projects/presentation/screens/saved_projects_screen.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/manager/nav_bar_investor_cubit/nav_bar_investor_cubit.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/widgets/bottom_nav_bar_founder.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/widgets/bottom_nav_bar_investor.dart';
import 'package:rafeeq_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:rafeeq_app/features/rate_founder/presentation/screens/rate_founder_screen.dart';
import '../../features/nav_bar/presentation/manager/nav_bar_founder_cubit/nav_bar_founder_cubit.dart';

abstract class AppRouter {
  static late final GoRouter router;

  static void initRouter() {
    router = GoRouter(
      initialLocation: Routes.onboarding,
      routes: [
        GoRoute(
          path: Routes.onboarding,
          builder: (context, state) => OnboardingScreen(),
        ),
        GoRoute(
          path: Routes.register,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: RegisterScreen(),
          ),
        ),

        GoRoute(
          path: Routes.login,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),
        ),
        GoRoute(
          path: Routes.verification,
          builder: (context, state) => VerificationScreen(),
        ),
        GoRoute(
          path: Routes.forgetPassword,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<SendOtpCubit>(),
            child: ForgetPasswordScreen(),
          ),
        ),
        GoRoute(
          path: Routes.resetPasswordScreen,
          builder: (context, state) => ResetPasswordScreen(),
        ),
        GoRoute(
          path: Routes.virfyOtpScreen,

          builder: (context, state) {
            final email = state.extra as String;
            return BlocProvider(
              create: (context) => getIt<ResendOtpCubit>(),
              child: VerifyOtpScreen(email: email),
            );
          },
        ),
        GoRoute(
          path: Routes.navbarFounder,
          builder: (context, state) => BlocProvider(
            create: (context) => NavBarFounderCubit(),
            child: CustomBottomNavBarFounder(),
          ),
        ),
        GoRoute(
          path: Routes.navbarInvestor,
          builder: (context, state) => BlocProvider(
            create: (context) => NavBarInvestorCubit(),
            child: BottomNavBarInvestor(),
          ),
        ),
        GoRoute(
          path: Routes.popularQuestionsScreen,
          builder: (context, state) => PopularQuestionsScreen(),
        ),
        GoRoute(
          path: Routes.termsAndConditionScreen,
          builder: (context, state) => TermsAndConditionScreen(),
        ),
        GoRoute(
          path: Routes.chatScreen,
          builder: (context, state) => ChatScreen(),
        ),
        GoRoute(
          path: Routes.createProjectSteps,
          builder: (context, state) => CreateProjectCoordinator(),
        ),
        GoRoute(
          path: Routes.founderAccountScreen,
          builder: (context, state) => FounderAccountScreen(),
        ),
        GoRoute(
          path: Routes.applyToProjectScreen,
          builder: (context, state) => ApplyToProjectScreen(),
        ),
        GoRoute(
          path: Routes.investorAccountScreen,
          builder: (context, state) => InvestorAccountScreen(),
        ),
        GoRoute(
          path: Routes.rateFounderScreen,
          builder: (context, state) => RateFounderScreen(),
        ),
        GoRoute(
          path: Routes.savedProjectsScreen,
          builder: (context, state) => SavedProjectsScreen(),
        ),
      ],
    );
  }
}
