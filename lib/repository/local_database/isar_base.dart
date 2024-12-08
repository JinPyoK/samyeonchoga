import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samyeonchoga/model/gold/gold_storage.dart';

sealed class Isarbase {
  static Isar? _isar;

  static const int fixedId = 1;

  static Future<void> initIsarbase() async {
    final path = await getApplicationDocumentsDirectory();

    Isarbase._isar = await Isar.open(
      [
        GoldStorageSchema,
      ],
      directory: path.path,
    );
  }

  static Future<void> write(Object data) async {
    await Isarbase._isar!.writeTxn(() async {
      switch (data.runtimeType.toString()) {
        case 'GoldStorage':
          await Isarbase._isar!.goldStorages.put(data as GoldStorage);
        default:
          return;
      }
    });
  }

  static Future<Object?> read(Object data) async {
    Object? result;

    switch (data.runtimeType.toString()) {
      case 'GoldStorage':
        result = await Isarbase._isar!.goldStorages.get(Isarbase.fixedId);
      default:
        return null;
    }

    return result;
  }
}
