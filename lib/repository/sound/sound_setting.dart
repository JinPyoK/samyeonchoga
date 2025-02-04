import 'package:shared_preferences/shared_preferences.dart';

final class SoundVolumeRepository {
  Future<double> getSoundVolume() async {
    final pref = await SharedPreferences.getInstance();

    final double? volume = pref.getDouble('soundVolume');

    return volume ?? 0.5;
  }

  Future<void> setSoundVolume({required double volume}) async {
    try {
      final pref = await SharedPreferences.getInstance();

      await pref.setDouble('soundVolume', volume);
    } catch (_) {}
  }
}
