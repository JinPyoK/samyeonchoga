import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/model/rank/rank_model.dart';
import 'package:samyeonchoga/provider/gold/gold_entity.dart';
import 'package:samyeonchoga/provider/in_game/in_game_gold_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_round_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_save_entity.dart';
import 'package:samyeonchoga/provider/rank/rank_provider.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_snackbar.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';

class InGameResult extends ConsumerStatefulWidget {
  const InGameResult({super.key});

  @override
  ConsumerState<InGameResult> createState() => _InGameResultState();
}

class _InGameResultState extends ConsumerState<InGameResult> {
  final _textController = TextEditingController();

  bool _canRankRegister = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roundResult = ref.read(inGameRoundProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "게임 종료",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: blackColor,
              fontSize: 16 * hu,
            ),
          ),
          SizedBox(height: 20 * hu),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100 * wu,
                height: 50 * hu,
                child: FittedBox(
                  child: Text(
                    roundResult.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              const Text("Round"),
            ],
          ),
          SizedBox(height: 30 * hu),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: "닉네임을 입력해주세요",
            ),
            maxLength: 10,
          ),
          SizedBox(height: 30 * hu),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _canRankRegister
                    ? () async {
                        try {
                          final nickName = _textController.text;

                          if (nickName == '') {
                            if (context.mounted) {
                              showCustomSnackBar(context, "닉네임을 1글자 이상 입력해주세요");
                            }
                            return;
                          }

                          await ref.read(rankProvider.notifier).registerRank(
                                rankModel: RankModel.autoId(
                                  round: roundResult,
                                  nickName: nickName,
                                ),
                              );

                          _canRankRegister = false;
                          setState(() {});
                          if (context.mounted) {
                            showCustomSnackBar(context, "랭킹에 등록하였습니다");
                          }
                        } catch (_) {
                          if (context.mounted) {
                            showCustomSnackBar(
                                context, "랭킹 등록에 실패했습니다. 다시 시도해 주세요.");
                          }
                        }
                      }
                    : null,
                child: const Text("랭킹 등록"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: redColor,
                ),
                onPressed: () async {
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
                child: const Text("게임 종료"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
