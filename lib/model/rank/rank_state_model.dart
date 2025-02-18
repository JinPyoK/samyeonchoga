enum RankStateEnum { fetch, loading, error }

final class RankStateModel {
  final RankStateEnum state;
  final String? errorMessage;

  RankStateModel({required this.state, this.errorMessage});
}
