class AppConstant {
  static const none = 'None';
  static const unchartedInt = -1;
  static const unchartedListString = <String>[];
  static const unchartedDouble = -1.0;
  static const unchartedBool = null;
  static const keyPrefToken = 'personal-token';
  static const fail = 'fail';
  static const success = 'success';
  static const defaultAvatarUrl =
      'https://firebasestorage.googleapis.com/v0/b/chatto-453c2.appspot.com/o/images%2Fchatto_default_avatar.jpg?alt=media&token=35f92def-076c-437d-8895-c03bbf0644fa';
}

enum LoginState { pending, loading, successful, failed, tokenFailed }
enum AppState { pending, loading, successful, failed }
