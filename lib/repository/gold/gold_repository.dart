import 'package:shared_preferences/shared_preferences.dart';

final class GoldRepository {
  Future<int> getGolds() async {
    final pref = await SharedPreferences.getInstance();

    final int? gold = pref.getInt('golds');

    return gold ?? 5000;
  }

  Future<void> setGolds({required int golds}) async {
    try {
      final pref = await SharedPreferences.getInstance();

      await pref.setInt('golds', golds);
    } catch (_) {}
  }
}
