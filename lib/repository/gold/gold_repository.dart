import 'package:isar/isar.dart';
import 'package:samyeonchoga/core/local_database/isar_base.dart';

part 'gold_repository.g.dart';

@collection
final class GoldRepository {
  Id id = Isarbase.fixedId;

  int gold = 5000;

  void addGold(int gold) {
    this.gold += gold;
  }

  /// 앱 첫 실행시 한 번 호출
  Future<void> readGold() async {
    final result = await Isarbase.read(this);
    if (result == null) return;
    final myGold = result as GoldRepository;

    /// 업데이트 할 때 골드가 -1000골드로 되어있었음. Isar 버그?
    if (myGold.gold < 0) {
      gold = 0;
    } else {
      gold = myGold.gold;
    }
  }

  /// 1. 게임 시작
  /// 2. 게임 외통 및 종료 또는 게임 저장하지 않고 종료
  /// 3. 광고 시청 후 골드 보상
  Future<void> writeGold() async {
    await Isarbase.write(this);
  }
}
