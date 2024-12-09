final class RankModel {
  /// DateTime.toLocal().toString()
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'round': round,
      'nickName': nickName,
    };
  }
}
