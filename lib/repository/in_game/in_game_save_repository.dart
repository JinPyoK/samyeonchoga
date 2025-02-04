import 'package:isar/isar.dart';
import 'package:samyeonchoga/core/local_database/isar_base.dart';
import 'package:samyeonchoga/model/in_game/in_game_save_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'in_game_save_repository.g.dart';

@collection
final class InGameSaveRepository {
  Id id = Isarbase.fixedId;

  int move = 0;

  int inGameGold = 0;

  List<InGameSaveModel> inGameSaveDataList = [];

  /// 게임 데이터 백업
  void backupInGameData({
    required int move,
    required int inGameGold,
    required List<InGameSaveModel> inGameSaveDataList,
  }) {
    this.move = move;
    this.inGameGold = inGameGold;
    this.inGameSaveDataList = inGameSaveDataList;
  }

  /// 홈 스크린에서 게임 시작 버튼 누르면 호출
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

final class InGameSavedDataRepository {
  Future<List<String>> getSavedData() async {
    final pref = await SharedPreferences.getInstance();

    final List<String>? savedData = pref.getStringList('savedData');

    return savedData ?? <String>[];
  }

  Future<void> saveInGameData({required List<String> inGameData}) async {
    try {
      final pref = await SharedPreferences.getInstance();

      await pref.setStringList('savedData', inGameData);
    } catch (_) {}
  }

  Future<void> removeInGameData() async {
    try {
      final pref = await SharedPreferences.getInstance();

      await pref.remove('savedData');
    } catch (_) {}
  }
}
