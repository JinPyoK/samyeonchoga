import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samyeonchoga/model/gold/gold.dart';

sealed class Isarbase {
  static Isar? _isar;

  static int id = 1;

  static Future<void> initIsarbase() async {
    final path = await getApplicationDocumentsDirectory();

    Isarbase._isar = await Isar.open(
      [],
      directory: path.path,
    );
  }

  static Future<void> write(Object data) async {
    await Isarbase._isar!.writeTxn(() async {
      switch (data.runtimeType.toString()) {
        case 'Gold':
          await Isarbase._isar!.golds.put(data as Gold);
        default:
          return;
      }
    });
  }

  static Future<Object?> read(Object data) async {
    Object? result;

    switch (data.runtimeType.toString()) {
      case 'Gold':
        result = await Isarbase._isar!.golds.get(Isarbase.id);
      default:
        return null;
    }

    return result;
  }
}
