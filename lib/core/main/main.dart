import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/core/constant/native_key.dart';
import 'package:samyeonchoga/core/firebase/firebase_options.dart';
import 'package:samyeonchoga/provider/auth/oauth_provider.dart';
import 'package:samyeonchoga/ui/auth/screen/auth_screen.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/screen/home_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initSdks();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    wu = MediaQuery.of(context).size.width / 320;
    hu = MediaQuery.of(context).size.height / 690;

    return ProviderScope(
      child: MaterialApp(
        theme: _customTheme,
        title: 'samyeonchoga',
        home: isLogin() ? const HomeNavigationScreen() : const AuthScreen(),
      ),
    );
  }
}

Future<void> _initSdks() async {
  /// 파이어베이스
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// 카카오
  KakaoSdk.init(
    nativeAppKey: nativeAppKey,
    javaScriptAppKey: javaScriptKey,
  );
}

final _customTheme = ThemeData(
  textTheme: GoogleFonts.songMyungTextTheme(),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: blackColor,
    actionTextColor: whiteColor,
  ),
  scaffoldBackgroundColor: whiteColor,
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: whiteColor,
    indicatorColor: orangeColor,
  ),
);
