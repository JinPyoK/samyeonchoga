import 'package:isar/isar.dart';
import 'package:samyeonchoga/repository/local_database/isar_base.dart';

part 'gold_storage.g.dart';

@collection
final class GoldStorage {
  Id id = Isarbase.fixedId;

  int gold = 5000;

  void addGold(int gold) {
    this.gold += gold;
  }

  /// 앱 첫 실행시 한 번 호출 할듯
  Future<void> readGold() async {
    final result = await Isarbase.read(this);
    if (result == null) return;
    final myGold = result as GoldStorage;
    gold = myGold.gold;
  }

  Future<void> writeGold() async {
    await Isarbase.write(this);
  }
}
