import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/core/firebase/firebase_options.dart';
import 'package:samyeonchoga/repository/privacy_policy/privacy_policy_repository.dart';
import 'package:samyeonchoga/ui/agreement/screen/privacy_policy_screen.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';
import 'package:samyeonchoga/ui/common/screen/home_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initGame();

  runApp(const Samyeonchoga());
}

class Samyeonchoga extends StatelessWidget {
  const Samyeonchoga({super.key});

  @override
  Widget build(BuildContext context) {
    wu = MediaQuery.of(context).size.width / 320;
    hu = MediaQuery.of(context).size.height / 690;

    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _customTheme,
        title: 'samyeonchoga',
        home: FutureBuilder(
          future: PrivacyPolicyRepository().getPrivacyPolicy(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Container());
            } else if (snapshot.hasData) {
              if (snapshot.data!) {
                return const HomeNavigationScreen();
              } else {
                return const PrivacyPolicyScreen();
              }
            } else {
              return const Scaffold(
                body: Center(child: Text("The game cannot be run")),
              );
            }
          },
        ),
      ),
    );
  }
}

Future<void> _initGame() async {
  /// 기기 세로 모드 고정
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// 파이어베이스
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// 구글 애드몹
  await MobileAds.instance.initialize();
}

final _customTheme = ThemeData(
  textTheme: GoogleFonts.nanumGothicTextTheme(),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: blackColor,
    actionTextColor: whiteColor,
  ),
  scaffoldBackgroundColor: whiteColor,
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: whiteColor,
    indicatorColor: woodColor,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 3),
        borderRadius: BorderRadius.circular(5),
      ),
      foregroundColor: blackColor,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: whiteColor,
      backgroundColor: woodColor,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      disabledBackgroundColor: Colors.grey,
    ),
  ),
);
