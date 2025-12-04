import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/screens/register_screen.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/widgets/bottom_nav_bar.dart';
import 'package:rafeeq_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:rafeeq_app/features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/nav_bar/presentation/manager/nav_bar_cubit/nav_bar_cubit.dart';

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
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: Routes.welcome,
          builder: (context, state) => WelcomeScreen(),
        ),
        GoRoute(path: Routes.login, builder: (context, state) => LoginScreen()),
        GoRoute(
          path: Routes.navbar,
          builder: (context, state) => BlocProvider(
            create: (context) => NavBarCubit(),
            child: CustomBottomNavBar(),
          ),
        ),
      ],
    );
  }
}
