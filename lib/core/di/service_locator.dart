import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_account/data/repos/get_my_founder_profile_repo.dart';
import 'package:rafeeq_app/features/founder_account/data/repos/update_founder_profile_repo.dart';
import 'package:rafeeq_app/features/founder_account/presentation/logic/get_founder_data/founder_profile_cubit.dart';
import 'package:rafeeq_app/features/founder_account/presentation/logic/update_founder_profile/update_founder_profile_cubit.dart';
import 'package:rafeeq_app/features/investor_account/data/repos/get_my_investor_profile_repo.dart';
import 'package:rafeeq_app/features/investor_account/data/repos/update_investor_profile_repo.dart';
import 'package:rafeeq_app/features/investor_account/data/repos/upload_investor_picture_repo.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/my_investor_profile/my_investor_profile_cubit.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/update_investor_profile/update_investor_profile_cubit.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/upload_investor_profile_picture/upload_investor_profile_picture_cubit.dart';

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

  getIt.registerLazySingleton<GetMyInvestorProfileRepo>(
    () => GetMyInvestorProfileRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<MyInvestorProfileCubit>(
    () => MyInvestorProfileCubit(getIt<GetMyInvestorProfileRepo>()),
  );

  getIt.registerLazySingleton<UpdateInvestorProfileRepo>(
    () => UpdateInvestorProfileRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<UpdateInvestorProfileCubit>(
    () => UpdateInvestorProfileCubit(getIt<UpdateInvestorProfileRepo>()),
  );

  getIt.registerLazySingleton<UploadInvestorPictureRepo>(
    () => UploadInvestorPictureRepo(getIt<ApiClient>()),
  );
  getIt.registerFactory<UploadInvestorProfilePictureCubit>(
    () => UploadInvestorProfilePictureCubit(getIt<UploadInvestorPictureRepo>()),
  );

  getIt.registerLazySingleton<UpdateFounderProfileRepo>(
    () => UpdateFounderProfileRepo(getIt<ApiClient>(), getIt<ApiHandler>()),
  );
  getIt.registerFactory<UpdateFounderProfileCubit>(
    () => UpdateFounderProfileCubit(getIt<UpdateFounderProfileRepo>()),
  );
}
