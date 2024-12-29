import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/core/firebase/firebase_options.dart';
import 'package:samyeonchoga/core/local_database/isar_base.dart';
import 'package:samyeonchoga/provider/gold/gold_entity.dart';
import 'package:samyeonchoga/provider/sound/sound_setting.dart';
import 'package:samyeonchoga/ui/audio/controller/sound_play.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';
import 'package:samyeonchoga/ui/common/screen/home_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initGame();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    wu = MediaQuery.of(context).size.width / 320;
    hu = MediaQuery.of(context).size.height / 690;

    /// 이미지 Preload
    unawaited(imagePreload(context));

    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _customTheme,
        title: 'samyeonchoga',
        home: const HomeNavigationScreen(),
      ),
    );
  }
}

Future<void> _initGame() async {
  /// 기기 세로 모드 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// 파이어베이스
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Isar 로컬 데이터베이스
  await Isarbase.initIsarbase();

  /// 앱 시작시 골드 로드하기
  await myGold.readGold();

  /// 앱 시작시 사운드 설정 로드하기
  await soundSetting.readSoundVolume();

  /// 구글 애드몹
  unawaited(MobileAds.instance.initialize());

  /// 앱 시작시 오디오 로드 및 볼륨 설정
  await initAudio();
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      foregroundColor: whiteColor,
      backgroundColor: woodColor,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      disabledBackgroundColor: Colors.grey,
    ),
  ),
);
