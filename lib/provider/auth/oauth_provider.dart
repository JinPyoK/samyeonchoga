import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:samyeonchoga/core/constant/native_key.dart';

part 'apple_login.dart';
part 'google_login.dart';
part 'kakao_login.dart';

final _auth = FirebaseAuth.instance;

String? _idToken = '';
String? _accessToken = '';

Future<String?> oAuthLogin({required String vendor}) async {
  String? errorCode;
  late OAuthCredential credential;

  try {
    if (vendor == 'kakao') {
      errorCode = await _signInWithKakao();

      final kakaoProvider = OAuthProvider('oidc.kakao');

      credential = kakaoProvider.credential(
        idToken: _idToken,
        accessToken: _accessToken,
      );
    } else if (vendor == 'google') {
      errorCode = await _signInWithGoogle();

      credential = GoogleAuthProvider.credential(
        idToken: _idToken,
        accessToken: _accessToken,
      );
    } else if (vendor == 'apple') {
      errorCode = await _signInWithApple();
    } else {
      errorCode = '알 수 없는 에러 발생';
    }

    if (errorCode != null) {
      return errorCode;
    }

    await _auth.signInWithCredential(credential);
    return null;
  } on Exception catch (_) {
    return '로그인 도중 에러 발생';
  }
}

/// 로그인 여부
bool isLogin() => _auth.currentUser == null;

/// UID 가지고 오기
String? getUID() => _auth.currentUser?.uid;

/// 이름 가지오 오기 (디스플레이 네임 제대로 설정되는지 확인)
String? getDisplayName() => _auth.currentUser?.displayName;
