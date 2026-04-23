import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_account/data/models/founder_profile.dart';
import 'package:rafeeq_app/features/founder_account/presentation/logic/get_founder_data/founder_profile_cubit.dart';
import 'package:rafeeq_app/features/founder_account/presentation/logic/update_founder_profile/update_founder_profile_cubit.dart';
import 'package:rafeeq_app/features/founder_account/presentation/screens/update_founder_profile_screen.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/project_details/project_details_cubit.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/screens/project_details_screen.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_model.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/my_investor_profile/my_investor_profile_cubit.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/update_investor_profile/update_investor_profile_cubit.dart';
import 'package:rafeeq_app/features/investor_account/presentation/screens/update_investor_profile_screen.dart';

import 'package:rafeeq_app/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:rafeeq_app/features/onboarding/presentation/screens/welcome_screen.dart';

abstract class AppRouter {
  static late final GoRouter router;

  static void initRouter() {
    router = GoRouter(
      initialLocation: Routes.splash,
      routes: [
        GoRoute(
          path: Routes.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: Routes.onboarding,
          builder: (context, state) => OnboardingScreen(),
        ),
        GoRoute(
          path: Routes.welcome,
          builder: (context, state) => WelcomeScreen(),
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
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: const LoginScreen(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            );
          },
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
            create: (context) =>
                getIt<FounderProfileCubit>()..fetchFounderProfile(),
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
        GoRoute(
          path: Routes.updateInvestorProfile,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            final cubit = data["cubit"] as MyInvestorProfileCubit;
            final profile = data["profile"] as InvestorProfileModel;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<UpdateInvestorProfileCubit>(),
                ),
                BlocProvider.value(value: cubit),
              ],
              child: UpdateInvestorProfileScreen(profile: profile),
            );
          },
        ),
        GoRoute(
          path: Routes.updateFounderProfile,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            final profile = data["profile"] as FounderProfile;
            final cubit = data["cubit"] as FounderProfileCubit;
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => getIt<UpdateFounderProfileCubit>()),
                BlocProvider.value(value: cubit),
              ],
              child: UpdateFounderProfileScreen(profile: profile),
            );
          },
        ),
        GoRoute(
          path: Routes.projectDetailsScreen,
          builder: (context, state) {
            final projectId = state.extra as int;
            return BlocProvider(
              create: (context) => getIt<ProjectDetailsCubit>(),
              child: ProjectDetailsScreen(projectId: projectId),
            );
          },
        ),
      ],
    );
  }
}
