import 'package:chatto_app/service/navigator_service.dart';
import 'package:get_it/get_it.dart';

void setUpServiceLocator(){
  GetIt getIt = GetIt.I;
  getIt.registerLazySingleton<NavigatorService>(() => NavigatorService());
}