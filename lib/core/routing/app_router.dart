import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/screens/popular_questions_screen.dart';
import 'package:rafeeq_app/core/common/screens/terms_and_condition_screen.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:rafeeq_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/screens/register_screen.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/screens/verification_screen.dart';
import 'package:rafeeq_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/create_project_coordinator.dart';
import 'package:rafeeq_app/features/founder_account/presentation/screens/founder_account_screen.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/manager/nav_bar_investor_cubit/nav_bar_investor_cubit.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/widgets/bottom_nav_bar_founder.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/widgets/bottom_nav_bar_investor.dart';
import 'package:rafeeq_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:rafeeq_app/features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/nav_bar/presentation/manager/nav_bar_founder_cubit/nav_bar_founder_cubit.dart';

abstract class AppRouter {
  static late final GoRouter router;

  static void initRouter() {
    router = GoRouter(
      initialLocation: Routes.navbarInvestor,
      routes: [
        GoRoute(
          path: Routes.onboarding,
          builder: (context, state) => OnboardingScreen(),
        ),
        GoRoute(
          path: Routes.register,
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: Routes.welcome,
          builder: (context, state) => WelcomeScreen(),
        ),
        GoRoute(path: Routes.login, builder: (context, state) => LoginScreen()),
        GoRoute(
          path: Routes.verification,
          builder: (context, state) => VerificationScreen(),
        ),
        GoRoute(
          path: Routes.forgetPassword,
          builder: (context, state) => ForgetPasswordScreen(),
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
      ],
    );
  }
}
