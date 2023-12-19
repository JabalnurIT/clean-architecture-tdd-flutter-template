part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();
  final api = API();
  final imagePicker = ImagePicker();
  final geolocator = GeolocatorPlatform.instance;
  final filePicker = FilePicker.platform;

  await _initCore(
      prefs: prefs,
      dio: dio,
      api: api,
      imagePicker: imagePicker,
      geolocator: geolocator,
      filePicker: filePicker);
  await _initAuth();
}

Future<void> _initCore({
  required SharedPreferences prefs,
  required Dio dio,
  required API api,
  required ImagePicker imagePicker,
  required GeolocatorPlatform geolocator,
  required FilePicker filePicker,
}) async {
  sl
    ..registerLazySingleton(() => dio)
    ..registerLazySingleton(() => api)
    ..registerLazySingleton(() => prefs)
    ..registerLazySingleton(() => imagePicker)
    ..registerLazySingleton(() => geolocator)
    ..registerLazySingleton(() => filePicker);
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signInWithCredential: sl(),
        updateUser: sl(),
        signOut: sl(),
        addPhoto: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignInWithCredential(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    ..registerLazySingleton(() => AddPhoto(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        sharedPreferences: sl(),
        dio: sl(),
        api: sl(),
      ),
    );
}
