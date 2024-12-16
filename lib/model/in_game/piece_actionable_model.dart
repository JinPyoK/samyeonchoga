import 'package:samyeonchoga/model/in_game/piece_base_model.dart';

final class PieceActionableModel extends PieceOrJustActionable {
  final int targetX;
  final int targetY;
  final int targetValue;

  PieceActionableModel({
    required this.targetX,
    required this.targetY,
    required this.targetValue,
  });
}
