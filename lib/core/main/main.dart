import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/core/firebase/firebase_options.dart';
import 'package:samyeonchoga/repository/local_database/isar_base.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
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

    return ProviderScope(
      child: MaterialApp(
        theme: _customTheme,
        title: 'samyeonchoga',
        home: const HomeNavigationScreen(),
      ),
    );
  }
}

Future<void> _initGame() async {
  /// 파이어베이스
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Isar 로컬 데이터베이스
  await Isarbase.initIsarbase();
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
    ),
  ),
);
