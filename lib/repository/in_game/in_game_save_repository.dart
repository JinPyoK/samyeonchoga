import 'package:isar/isar.dart';
import 'package:samyeonchoga/core/local_database/isar_base.dart';
import 'package:samyeonchoga/model/in_game/in_game_save_model.dart';

part 'in_game_save_repository.g.dart';

@collection
final class InGameSaveRepository {
  Id id = Isarbase.fixedId;

  int round = 0;

  int inGameGold = 0;

  List<InGameSaveModel> inGameSaveDataList = [];

  /// 게임 데이터 백업
  void backupInGameData({
    required int round,
    required int inGameGold,
    required List<InGameSaveModel> inGameSaveDataList,
  }) {
    this.round = round;
    this.inGameGold = inGameGold;
    this.inGameSaveDataList = inGameSaveDataList;
  }

  /// 앱 첫 실행시 한 번 호출
  Future<InGameSaveRepository?> readInGameSave() async {
    final result = await Isarbase.read(this);

    return result as InGameSaveRepository?;
  }

  /// 게임 저장 후 종료
  Future<void> writeInGameSave() async {
    await Isarbase.write(this);
  }

  /// 게임 데이터 삭제하기
  Future<void> deleteInGameSave() async {
    await Isarbase.inGameDelete(this);
  }
}
