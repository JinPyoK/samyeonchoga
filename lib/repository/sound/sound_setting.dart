import 'package:isar/isar.dart';
import 'package:samyeonchoga/core/local_database/isar_base.dart';

part 'sound_setting.g.dart';

@collection
final class SoundSetting {
  Id id = Isarbase.fixedId;

  double volume = 5;

  void changeVolume(double volume) {
    this.volume = volume;
  }

  /// 앱 첫 실행시 한 번 호출
  Future<void> readSoundVolume() async {
    final result = await Isarbase.read(this);
    if (result == null) return;

    final mySoundVolume = result as SoundSetting;
    volume = mySoundVolume.volume;
  }

  Future<void> writSoundVolume() async {
    await Isarbase.write(this);
  }
}
