import 'package:chatto_app/services/app_shared_preference.dart';
import 'package:chatto_app/services/navigator_service.dart';
import 'package:get_it/get_it.dart';

void setUpServiceLocator() {
  GetIt getIt = GetIt.I;
  getIt.registerLazySingleton<AppSharedPreference>(() => AppSharedPreference());
  getIt.registerLazySingleton<NavigatorService>(() => NavigatorService());
}


