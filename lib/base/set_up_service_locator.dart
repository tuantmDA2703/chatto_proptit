import 'package:chatto_app/screen/authentication/sign_up/sign_up_bloc.dart';

import 'package:chatto_app/repository/firebase_repositoty_impl.dart';
import 'package:chatto_app/services/app_shared_preference.dart';
import 'package:chatto_app/services/firebase_service.dart';
import 'package:chatto_app/services/navigator_service.dart';
import 'package:get_it/get_it.dart';

void setUpServiceLocator() {
  GetIt getIt = GetIt.I;
  getIt.registerLazySingleton<AppSharedPreference>(() => AppSharedPreference());
  getIt.registerLazySingleton<NavigatorService>(() => NavigatorService());
  
  getIt.registerFactory<SignUpBloc>(() => SignUpBloc(firebaseRepository: getIt.get<FirebaseRepositoryImpl>()));
  getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());
  getIt.registerLazySingleton<FirebaseRepositoryImpl>(() => FirebaseRepositoryImpl());
}
