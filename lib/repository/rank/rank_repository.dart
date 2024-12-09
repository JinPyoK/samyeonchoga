import 'package:firebase_database/firebase_database.dart';
import 'package:samyeonchoga/model/rank/rank_model.dart';

final _realtime = FirebaseDatabase.instance;

final class RankRepository {
  factory RankRepository() => RankRepository._();

  RankRepository._();

  /// 랭크 데이터 가져오기
  Future<List<RankModel>> readRank() async {
    final snapShot = await _realtime.ref().child('rank').get();

    List<RankModel> rankList = [];

    if (snapShot.value == null) return rankList;

    /// 리얼타임 데이터베이스는 Map<Object?, Object?>로 반환한다.
    final rankListObject =
        (snapShot.value as Map<Object?, Object?>).cast<String, dynamic>();

    for (String key in rankListObject.keys) {
      rankList.add(
        RankModel.fromJson(
          {
            'id': key,
            'round': rankListObject[key]['round'] as int,
            'nickName': rankListObject[key]['nickName'] as String,
          },
        ),
      );
    }

    /// 순위대로 오름차순 정렬
    rankList.sort((p, n) => n.round.compareTo(p.round));

    return rankList;
  }

  /// 랭크 데이터 통째로 덮어쓰기
  /// 처음엔 100등의 데이터만 지우고, 새로운 데이터만 등록하려고 하였으나
  /// 어느 유저 2명 이상이 동시에 순위를 등록하려고 하게 되면, 데이터 싱크에 문제가 발생하여
  /// 데이터가 100개 넘게 쓰여지게 되는 상황이 나오는 듯 하다.
  Future<void> writeRank({required List<RankModel> rankList}) async {
    Map<String, dynamic> rankData = {};

    for (RankModel model in rankList) {
      rankData.addAll({
        model.id: {
          'round': model.round,
          'nickName': model.nickName,
        },
      });
    }

    await _realtime.ref('rank').set(rankData);
  }
}
