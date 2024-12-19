import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samyeonchoga/repository/gold/gold_repository.dart';
import 'package:samyeonchoga/repository/sound/sound_setting.dart';

sealed class Isarbase {
  static Isar? _isar;

  static const int fixedId = 1;

  static Future<void> initIsarbase() async {
    final path = await getApplicationDocumentsDirectory();

    Isarbase._isar = await Isar.open(
      [
        GoldRepositorySchema,
        SoundSettingSchema,
      ],
      directory: path.path,
    );
  }

  static Future<void> write(Object data) async {
    await Isarbase._isar!.writeTxn(() async {
      switch (data.runtimeType.toString()) {
        case 'GoldRepository':
          await Isarbase._isar!.goldRepositorys.put(data as GoldRepository);
        case 'SoundSetting':
          await Isarbase._isar!.soundSettings.put(data as SoundSetting);
        default:
          return;
      }
    });
  }

  static Future<Object?> read(Object data) async {
    Object? result;

    switch (data.runtimeType.toString()) {
      case 'GoldRepository':
        result = await Isarbase._isar!.goldRepositorys.get(Isarbase.fixedId);
      case 'SoundSetting':
        result = await Isarbase._isar!.soundSettings.get(Isarbase.fixedId);
      default:
        return null;
    }

    return result;
  }
}
