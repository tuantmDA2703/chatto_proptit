import 'package:chatto_app/base/bloc_base.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


///   PageBase which extended by all page in project.
///   It extends StatefulWidget because we need know about lifecycle of page.
/// 
///   You can implement function:
///   	- [PagefulBase.onInit] will call when page [initState]
///   	- [PagefulBase.onInactive] will call when page [inactive]
///   	- [PagefulBase.onResumed] will call when page [resumed]
///   	- [PagefulBase.onPaused] will call when page [pause]
///   	- [PagefulBase.onDetached] will call when page [detached]
///   	- [PagefulBase.onDispose] will call when page [dispose]
/// 
/// 
///    Description about state:
/// 	- [resumed] : The application is visible and responding to user input.
/// 	- [inactive] : The application is in an inactive state and is not receiving user input. 
/// 				Apps in this state should assume that they may be [paused] at any time.
/// 	- [pause] : The application is not currently visible to the user, not responding to
/// 				user input, and running in the background.
/// 	- [detached] : The application is still hosted on a flutter engine but is detached from
/// 					any host views.


abstract class PagefulBase<@required T extends BlocBase> extends StatefulWidget {
  final T _bloc = GetIt.I.get<T>();
  T get bloc => _bloc;

  PagefulBase({Key? key}) : super(key: key);

  Widget build(BuildContext context);

  @mustCallSuper
  void onInit() {
    bloc.init();
  }

  @mustCallSuper
  void onDispose() {
    bloc.dispose();
  }

  void onInactive() {}

  void onResumed() {}

  void onPaused() {}

  void onDetached() {}

  @override
  State<PagefulBase> createState() => _PagefulBaseState();
}

class _PagefulBaseState extends State<PagefulBase> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    widget.onInit();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        widget.onInactive();
        break;
      case AppLifecycleState.resumed:
        widget.onResumed();
        break;
      case AppLifecycleState.paused:
        widget.onPaused();
        break;
      case AppLifecycleState.detached:
        widget.onDetached();
        break;
    }
  }
}
