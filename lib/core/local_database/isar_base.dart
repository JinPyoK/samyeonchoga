import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samyeonchoga/repository/in_game/in_game_save_repository.dart';

sealed class Isarbase {
  static Isar? _isar;

  static const int fixedId = 1;

  static Future<void> initIsarbase() async {
    final path = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        InGameSaveRepositorySchema,
      ],
      directory: path.path,
    );
  }

  static Future<void> write(Object data) async {
    await _isar!.writeTxn(() async {
      switch (data.runtimeType.toString()) {
        case 'InGameSaveRepository':
          await _isar!.inGameSaveRepositorys.put(data as InGameSaveRepository);
        default:
          return;
      }
    });
  }

  static Future<Object?> read(Object data) async {
    Object? result;

    switch (data.runtimeType.toString()) {
      case 'InGameSaveRepository':
        result = await _isar!.inGameSaveRepositorys.get(fixedId);
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
