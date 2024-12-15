import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

final class RedSaModel extends RedPieceBaseModel {
  RedSaModel({
    required super.x,
    required super.y,
  }) : super(
          team: Team.red,
          pieceType: PieceType.sa,
          value: 30,
          imageProvider: imageRedSa,
        );

  @override
  void searchActionable() {
    /// 현재 액션 가능한 리스트를 비워준다.
    actionable.clear();

    /// 기물이 갈 수 있는 길을 찾아서 리스트에 넣는다.
  }
}
