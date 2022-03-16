import 'package:chatto_app/repository/firebase_repositoty_impl.dart';
import 'package:chatto_app/services/app_shared_preference.dart';
import 'package:chatto_app/services/firebase_service.dart';
import 'package:chatto_app/services/navigator_service.dart';
import 'package:chatto_app/services/scaffold_messenger_service.dart';
import 'package:get_it/get_it.dart';

void setUpServiceLocator() {
  GetIt getIt = GetIt.I;
  getIt.registerLazySingleton<AppSharedPreference>(() => AppSharedPreference());
  getIt.registerLazySingleton<NavigatorService>(() => NavigatorService());
  getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());
  getIt.registerLazySingleton<FirebaseRepositoryImpl>(
      () => FirebaseRepositoryImpl());
  getIt.registerLazySingleton<ScaffoldMessengerService>(
      () => ScaffoldMessengerService());
}
