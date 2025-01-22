import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samyeonchoga/repository/gold/gold_repository.dart';
import 'package:samyeonchoga/repository/in_game/in_game_save_repository.dart';
import 'package:samyeonchoga/repository/privacy_policy/privacy_policy_repository.dart';
import 'package:samyeonchoga/repository/sound/sound_setting.dart';

sealed class Isarbase {
  static Isar? _isar;

  static const int fixedId = 1;

  static Future<void> initIsarbase() async {
    final path = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        PrivacyPolicyRepositorySchema,
        GoldRepositorySchema,
        SoundSettingSchema,
        InGameSaveRepositorySchema,
      ],
      directory: path.path,
    );
  }

  static Future<void> write(Object data) async {
    await _isar!.writeTxn(() async {
      switch (data.runtimeType.toString()) {
        case 'GoldRepository':
          await _isar!.goldRepositorys.put(data as GoldRepository);
        case 'SoundSetting':
          await _isar!.soundSettings.put(data as SoundSetting);
        case 'InGameSaveRepository':
          await _isar!.inGameSaveRepositorys.put(data as InGameSaveRepository);
        case 'PrivacyPolicyRepository':
          await _isar!.privacyPolicyRepositorys
              .put(data as PrivacyPolicyRepository);
        default:
          return;
      }
    });
  }

  static Future<Object?> read(Object data) async {
    Object? result;

    switch (data.runtimeType.toString()) {
      case 'GoldRepository':
        result = await _isar!.goldRepositorys.get(fixedId);
      case 'SoundSetting':
        result = await _isar!.soundSettings.get(fixedId);
      case 'InGameSaveRepository':
        result = await _isar!.inGameSaveRepositorys.get(fixedId);
      case 'PrivacyPolicyRepository':
        result = await _isar!.privacyPolicyRepositorys.get(fixedId);
      default:
        return null;
    }

    return result;
  }

  static Future<void> inGameDelete(InGameSaveRepository inGamaData) async {
    await Isarbase._isar!.writeTxn(() async {
      await _isar!.inGameSaveRepositorys.delete(fixedId);
    });
  }
}
