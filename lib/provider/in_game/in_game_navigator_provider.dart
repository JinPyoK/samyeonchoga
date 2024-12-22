import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/model/in_game/navigator_type_enum.dart';
import 'package:samyeonchoga/model/in_game/piece_actionable_model.dart';
import 'package:samyeonchoga/model/in_game/piece_base_model.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_footer_spawn_piece_provider.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_navigator_box.dart';

part 'in_game_navigator_provider.g.dart';

@Riverpod()
final class InGameNavigator extends _$InGameNavigator {
  @override
  List<InGameNavigatorBox> build() {
    return <InGameNavigatorBox>[];
  }

  void clearNavigator() {
    state = [];
  }

  void showPieceNavigator(List<PieceActionableModel> pieceActionableList) {
    clearNavigator();
    final navigatorBoxList = <InGameNavigatorBox>[];

    for (PieceActionableModel actionableModel in pieceActionableList) {
      navigatorBoxList
          .add(InGameNavigatorBox(pieceActionable: actionableModel));
    }

    state = List.from(navigatorBoxList);
  }

  void showSpawnNavigator() {
    clearNavigator();
    final navigatorBoxList = <InGameNavigatorBox>[];

    final pieceType = ref.read(inGameFooterSpawnPieceProvider);

    if (pieceType == PieceType.sa) {
      for (int i = 3; i < 6; i++) {
        for (int j = 7; j < 10; j++) {
          final pieceModel = inGameBoardStatus.getStatus(i, j);
          if (pieceModel is PieceActionableModel) {
            navigatorBoxList.add(
              InGameNavigatorBox(
                pieceActionable: PieceActionableModel(
                    targetX: i, targetY: j, targetValue: 0),
                navigatorType: NavigatorType.spawn,
              ),
            );
          }
        }
      }
    } else {
      for (int i = 0; i < 9; i++) {
        for (int j = 6; j < 10; j++) {
          final pieceModel = inGameBoardStatus.getStatus(i, j);
          if (pieceModel is PieceActionableModel) {
            navigatorBoxList.add(
              InGameNavigatorBox(
                pieceActionable: PieceActionableModel(
                    targetX: i, targetY: j, targetValue: 0),
                navigatorType: NavigatorType.spawn,
              ),
            );
          }
        }
      }
    }

    state = navigatorBoxList;
  }

  void showExecuteNavigator() {
    clearNavigator();
    final navigatorBoxList = <InGameNavigatorBox>[];

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 10; j++) {
        final pieceModel = inGameBoardStatus.getStatus(i, j);
        if (pieceModel is PieceBaseModel) {
          if (pieceModel.pieceType != PieceType.king) {
            navigatorBoxList.add(
              InGameNavigatorBox(
                pieceActionable: PieceActionableModel(
                    targetX: i, targetY: j, targetValue: 0),
                navigatorType: NavigatorType.execute,
              ),
            );
          }
        }
      }

      state = navigatorBoxList;
    }
  }
}
