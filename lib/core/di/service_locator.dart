import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:rafeeq_app/core/helpers/secure_storage_helper.dart';
import 'package:rafeeq_app/core/helpers/shared_pref_helper.dart';
import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/network/api_handler.dart';
import 'package:rafeeq_app/core/network/dio_factory.dart';
import 'package:rafeeq_app/core/network/network_manager.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/repos/resend_otp_repo.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/repos/reset_password_repo.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/repos/send_otp_repo.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/repos/verify_otp_repo.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/resend_otp/resend_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/reset_password/reset_password_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/send_otp/send_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/verify_otp/verify_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/login/data/repos/login_repo.dart';
import 'package:rafeeq_app/features/auth/login/presentation/logic/login_cubit/login_cubit.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/repos/register_repo.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/logic/register_cubit/register_cubit.dart';
import 'package:rafeeq_app/features/onboarding/presentation/logic/cubit/onboarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initServiceLocator() async {
  final sharedPrefs = await SharedPrefHelper.init();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<SecureStorageHelper>(
    () => SecureStorageHelper(getIt<FlutterSecureStorage>()),
  );

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());

  getIt.registerLazySingleton<DioFactory>(() => DioFactory());

  final dio = await getIt<DioFactory>().createDio();
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  getIt.registerLazySingleton<ApiHandler>(() => ApiHandler());

  getIt.registerLazySingleton<OnboardingCubit>(() => OnboardingCubit());

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );

  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepo>()));
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<RegisterRepo>()),
  );
  getIt.registerFactory<SendOtpCubit>(() => SendOtpCubit(getIt<SendOtpRepo>()));
  getIt.registerLazySingleton<SendOtpRepo>(
    () => SendOtpRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<ResendOtpCubit>(
    () => ResendOtpCubit(getIt<ResendOtpRepo>()),
  );
  getIt.registerLazySingleton<ResendOtpRepo>(
    () => ResendOtpRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<VerifyOtpCubit>(
    () => VerifyOtpCubit(getIt<VerifyOtpRepo>()),
  );
  getIt.registerLazySingleton<VerifyOtpRepo>(
    () => VerifyOtpRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(getIt<ResetPasswordRepo>()),
  );
  getIt.registerLazySingleton<ResetPasswordRepo>(
    () => ResetPasswordRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
}
