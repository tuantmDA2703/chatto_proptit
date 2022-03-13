import 'package:chatto_app/services/navigator_service.dart';
import 'package:get_it/get_it.dart';

class Utility{
  var navigator = GetIt.I<NavigatorService>();

  void logData(String key,String message){
    // ignore: avoid_print
    print('==>$key:$message');
  }

  DateTime getCurrentTime(){
    DateTime now = DateTime.now();
    return now;
  }
}