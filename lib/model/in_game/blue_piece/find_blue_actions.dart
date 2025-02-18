import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';

void findBlueActions(
  PieceOrJustActionable status,
  List<PieceActionableModel> pieceActionable,
) {
  if (status is PieceActionableModel) {
    pieceActionable.add(
      PieceActionableModel(
        targetX: status.targetX,
        targetY: status.targetY,
        targetValue: 0,
      ),
    );
  } else if (status is PieceBaseModel) {
    if (status.team == Team.red) {
      pieceActionable.add(
        PieceActionableModel(
          targetX: status.x,
          targetY: status.y,
          targetValue: status.value,
        ),
      );
    }
  }
}
