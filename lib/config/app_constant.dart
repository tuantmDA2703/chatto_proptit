import 'package:flutter/material.dart';

class AppConstant {
  static const none = 'None';
  static const unchartedInt = -1;
  static const unchartedListString = <String>[];
  static const unchartedDouble = -1.0;
  static const unchartedBool = null;
  static const keyPrefToken = 'persional-token';
}

enum LoginState { pending, loading, successful, failed, tokenFailed }
enum AppState { pending, loading, successful, failed, tokenFailed }

Widget handleWidgetAppState(
  AppState? state, {
  Widget Function()? onPending,
  required Widget Function() onLoading,
  required Widget Function() onSuccessful,
  required Widget Function() onFailed,
  Widget Function()? onTokenFailed,
}) {
  if (state == null) return const SizedBox.shrink();
  switch (state) {
    case AppState.pending:
      return onPending == null ? const SizedBox.shrink() : onPending();
    case AppState.loading:
      return onLoading();
    case AppState.successful:
      return onSuccessful();
    case AppState.failed:
      return onFailed();
    default:
      return onTokenFailed == null ? const SizedBox.shrink() : onTokenFailed();
  }
}
