import 'package:isar/isar.dart';
import 'package:samyeonchoga/repository/local_database/isar_base.dart';

part 'gold.g.dart';

@collection
final class Gold {
  Id id = Isarbase.id;

  int gold = 5000;

  void changeGold(int charge) {
    gold += charge;
  }

  Future<void> readGold() async {
    final result = await Isarbase.read(this);
    final myGold = result as Gold;
    gold = myGold.gold;
  }

  Future<void> writeGold() async {
    await Isarbase.write(this);
  }
}
