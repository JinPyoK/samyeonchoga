final class RankModel {
  /// DateTime => Realtime Database의 경로, 데이터 참조용
  final String id;

  /// Rank round
  final int round;

  /// User Nickname
  final String nickName;

  RankModel({required this.id, required this.round, required this.nickName});

  factory RankModel.autoId({required int round, required String nickName}) {
    return RankModel(
      id: _makeRankId(),
      round: round,
      nickName: nickName,
    );
  }

  factory RankModel.fromJson(Map<String, dynamic> json) {
    return RankModel(
      id: json['id'],
      round: json['round'] as int,
      nickName: json['nickName'] as String,
    );
  }

  /// 경로(Id) 제외
  Map<String, dynamic> toJson() {
    return {
      'round': round,
      'nickName': nickName,
    };
  }
}

/// 파이어베이스 리얼타임 데이터베이스의 경로에는 공백, 특수문자 등이 들어갈 수 없다
String _makeRankId() {
  String dateTimeString = DateTime.now().toLocal().toString();

  /// 숫자만 추출
  String onlyNumbers = dateTimeString.replaceAll(RegExp(r'[^0-9]'), '');

  return onlyNumbers;
}