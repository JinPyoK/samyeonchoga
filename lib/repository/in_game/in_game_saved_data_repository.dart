import 'package:shared_preferences/shared_preferences.dart';

/// [0] -> move
/// [1] -> gold
/// [2, 3, 4, 5 ...] -> Team, PieceType, X, Y
final class InGameSavedDataRepository {
  Future<List<String>> getSavedData() async {
    final pref = await SharedPreferences.getInstance();

    final List<String>? savedData = pref.getStringList('savedData');

    return savedData ?? <String>[];
  }

  Future<void> saveInGameData({required List<String> inGameData}) async {
    try {
      final pref = await SharedPreferences.getInstance();

      await pref.setStringList('savedData', inGameData);
    } catch (_) {}
  }

  Future<void> removeInGameData() async {
    try {
      final pref = await SharedPreferences.getInstance();

      await pref.remove('savedData');
    } catch (_) {}
  }
}
