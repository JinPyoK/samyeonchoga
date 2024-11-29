part of 'oauth_provider.dart';

Future<String?> _signInWithKakao() async {
  /// 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await isKakaoTalkInstalled()) {
    try {
      /// ID 토큰, 액세스 토큰이 담겨있습니다.
      final token = await UserApi.instance.loginWithKakaoTalk();

      /// 나에 대한 정보입니다.
      // final user = await UserApi.instance.me();

      _idToken = token.idToken;
      _accessToken = token.accessToken;
      
      return null;
    } catch (error) {
      /// 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      /// 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return "카카오 로그인 실패: ${error.code}";
      }

      /// 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        final token = await UserApi.instance.loginWithKakaoAccount();

        _idToken = token.idToken;
        _accessToken = token.accessToken;

        return null;
      } catch (error) {
        return '카카오계정으로 로그인 실패';
      }
    }
  } else {
    /// 앱에 카카오톡이 설치 안되어있을 때
    try {
      final token = await UserApi.instance.loginWithKakaoAccount();

      _idToken = token.idToken;
      _accessToken = token.accessToken;

      return null;
    } catch (error) {
      return '카카오계정으로 로그인 실패';
    }
  }
}
