import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/gold/gold_entity.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_gold_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_navigator_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_round_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_save_entity.dart';
import 'package:samyeonchoga/repository/in_game/in_game_save_repository.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_app_bar.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_body.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_footer.dart';

class InGameScreen extends ConsumerWidget {
  const InGameScreen({super.key, required this.gameHadSaved});

  final bool gameHadSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) async {
        if (canPopNow) {
          showCustomDialog(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "게임을 종료하시겠습니까?\n\n게임을 저장하지 않고 종료하면 남은 골드는 돌려받습니다.",
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () async {
                      canPopNow = false;

                      inGameSave = InGameSaveRepository();

                      final inGameGold = ref.read(inGameGoldProvider);
                      final round = ref.read(inGameRoundProvider);
                      final inGameSaveDataList =
                          inGameBoardStatus.refinePieceModelForSave();

                      inGameSave!.backupInGameData(
                        round: round,
                        inGameGold: inGameGold,
                        inGameSaveDataList: inGameSaveDataList,
                      );

                      await inGameSave!.writeInGameSave();

                      if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("게임 저장 후 종료")),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () async {
                      canPopNow = false;

                      final inGameGold = ref.read(inGameGoldProvider);

                      myGold.addGold(inGameGold);

                      await myGold.writeGold();

                      await inGameSave?.deleteInGameSave();

                      if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }

                      setStateGold!(() {});
                    },
                    child: const Text("저장하지 않고 종료")),
              ],
            ),
            actionButtonColor: Colors.grey,
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          ref.read(inGameNavigatorProvider.notifier).clearNavigator();
        },
        child: Scaffold(
          appBar: const InGameAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: InGameBody(gameHadSaved: gameHadSaved),
              ),
              const Expanded(
                flex: 1,
                child: InGameFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool canPopNow = false;
