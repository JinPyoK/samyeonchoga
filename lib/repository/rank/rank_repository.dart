import 'package:firebase_database/firebase_database.dart';
import 'package:samyeonchoga/model/rank/rank_model.dart';

final _realtime = FirebaseDatabase.instance;

final class RankRepository {
  factory RankRepository() => RankRepository._();

  RankRepository._();

  /// 랭크 데이터 가져오기
  Future<Object?> readRank() async {
    final snapShot = await _realtime.ref().child('rank').get();
    return snapShot.value;
  }

  /// 프로바이더에서 마지막 순위의 데이터 제거 후 랭크 데이터 쓰기
  /// targetId == null 이면 랭크 데이터가 100개 이하여서 삭제 없이 바로 추가하기
  Future<void> removeLastAndWriteRank(
      {required String? targetId, required RankModel model}) async {
    if (targetId != null) {
      await _realtime.ref().child('rank').child(targetId).remove();
    }
    await _realtime.ref().child('rank').child(model.id).set(model.toJson());
  }
}
