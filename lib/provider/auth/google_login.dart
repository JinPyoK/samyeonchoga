part of 'oauth_provider.dart';

Future<String?> _signInWithGoogle() async {
  /// Trigger the authentication flow
  try {
    final googleSignIn = GoogleSignIn(serverClientId: webClientId);

    final googleUser = await googleSignIn.signIn();

    /// Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) {
      return "구글 로그인 취소";
    }

    _idToken = googleAuth.idToken;
    _accessToken = googleAuth.accessToken;

    return null;
  } catch (e) {
    return "구글 로그인 도중 에러가 발생했습니다";
  }
}
