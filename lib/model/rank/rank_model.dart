final class RankModel {
  /// DateTime => Realtime Database의 경로, 데이터 참조용
  final String id;

  /// Rank round
  final int round;

  /// User Nickname
  final String nickName;

  RankModel({required this.id, required this.round, required this.nickName});

  factory RankModel.fromJson(Map<String, dynamic> json) {
    return RankModel(
        id: json['id'],
        round: json['round'] as int,
        nickName: json['nickName'] as String);
  }

  /// 경로(Id) 제외
  Map<String, dynamic> toJson() {
    return {
      'round': round,
      'nickName': nickName,
    };
  }
}
