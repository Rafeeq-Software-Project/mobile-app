import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_account/presentation/logic/cubit/founder_profile_cubit.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/my_investor_profile/my_investor_profile_cubit.dart';

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
          builder: (context, state) {
            final resetToken = state.extra as String;
            return BlocProvider(
              create: (_) => getIt<ResetPasswordCubit>(),
              child: ResetPasswordScreen(resetToken: resetToken),
            );
          },
        ),
        GoRoute(
          path: Routes.virfyOtpScreen,

          builder: (context, state) {
            final email = state.extra as String;
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<ResendOtpCubit>()),
                BlocProvider(create: (context) => getIt<VerifyOtpCubit>()),
              ],
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
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<FounderProfileCubit>(),
            child: FounderAccountScreen(),
          ),
        ),
        GoRoute(
          path: Routes.applyToProjectScreen,
          builder: (context, state) => ApplyToProjectScreen(),
        ),
        GoRoute(
          path: Routes.investorAccountScreen,
          builder: (context, state) => BlocProvider(
            create: (context) =>
                getIt<MyInvestorProfileCubit>()..fetchInvestorProfile(),
            child: InvestorAccountScreen(),
          ),
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
