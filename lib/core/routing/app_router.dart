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
import 'package:rafeeq_app/features/nav_bar_founder/presentation/widgets/bottom_nav_bar.dart';
import 'package:rafeeq_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:rafeeq_app/features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/nav_bar_founder/presentation/manager/nav_bar_cubit/nav_bar_cubit.dart';

abstract class AppRouter {
  static late final GoRouter router;

  static void initRouter() {
    router = GoRouter(
      initialLocation: Routes.navbar,
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
          path: Routes.navbar,
          builder: (context, state) => BlocProvider(
            create: (context) => NavBarCubit(),
            child: CustomBottomNavBar(),
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
      ],
    );
  }
}
