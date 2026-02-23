import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_profile/data/repos/get_my_founder_profile_repo.dart';
import 'package:rafeeq_app/features/founder_profile/presentation/logic/cubit/founder_profile_cubit.dart';

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

  getIt.registerLazySingleton<AuthLocalStorage>(() => AuthLocalStorage());

  getIt.registerLazySingleton<DioFactory>(() => DioFactory());
  final dio = await getIt<DioFactory>().createDio();
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));
  getIt.registerLazySingleton<ApiHandler>(() => ApiHandler());
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());

  getIt.registerLazySingleton<TokenManager>(
    () => TokenManager(getIt<AuthLocalStorage>(), getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<ApiClient>(), getIt<AuthLocalStorage>()),
  );

  getIt.registerLazySingleton<OnboardingCubit>(() => OnboardingCubit());

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<LoginRepo>(), getIt<AuthLocalStorage>()),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<RegisterRepo>(), getIt<AuthLocalStorage>()),
  );

  getIt.registerLazySingleton<SendOtpRepo>(
    () => SendOtpRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<SendOtpCubit>(() => SendOtpCubit(getIt<SendOtpRepo>()));

  getIt.registerLazySingleton<ResendOtpRepo>(
    () => ResendOtpRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<ResendOtpCubit>(
    () => ResendOtpCubit(getIt<ResendOtpRepo>()),
  );

  getIt.registerLazySingleton<VerifyOtpRepo>(
    () => VerifyOtpRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<VerifyOtpCubit>(
    () => VerifyOtpCubit(getIt<VerifyOtpRepo>()),
  );

  getIt.registerLazySingleton<ResetPasswordRepo>(
    () => ResetPasswordRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(getIt<ResetPasswordRepo>()),
  );
  getIt.registerLazySingleton<GetMyFounderProfileRepo>(
    () => GetMyFounderProfileRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<FounderProfileCubit>(
    () => FounderProfileCubit(getIt<GetMyFounderProfileRepo>()),
  );
}
