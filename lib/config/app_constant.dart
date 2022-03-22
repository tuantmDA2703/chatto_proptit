class AppConstant {
  static const none = 'None';
  static const unchartedInt = -1;
  static const unchartedListString = <String>[];
  static const unchartedDouble = -1.0;
  static const unchartedBool = null;
  static const keyPrefToken = 'persional-token';
}

enum LoginState { pending, loading, successful, failed, tokenFailed }
