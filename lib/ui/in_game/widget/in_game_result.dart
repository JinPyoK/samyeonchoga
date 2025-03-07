import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/model/rank/rank_model.dart';
import 'package:samyeonchoga/provider/context/global_context.dart';
import 'package:samyeonchoga/provider/in_game/in_game_move_provider.dart';
import 'package:samyeonchoga/provider/rank/rank_provider.dart';
import 'package:samyeonchoga/repository/in_game/in_game_saved_data_repository.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_snackbar.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';
import 'package:samyeonchoga/ui/in_game/controller/check_bad_words.dart';

import '../../../provider/in_game/in_game_gold_provider.dart'
    show inGameGoldProvider;
import '../../../repository/gold/gold_repository.dart' show GoldRepository;
import '../../common/screen/home_navigation_screen.dart' show myGolds;

class InGameResult extends ConsumerStatefulWidget {
  const InGameResult({super.key, required this.reason});

  final int reason;

  @override
  ConsumerState<InGameResult> createState() => _InGameResultState();
}

class _InGameResultState extends ConsumerState<InGameResult> {
  final _textController = TextEditingController();

  /// 랭크 1회 등록 후 버튼 비활성화
  bool _canRankRegister = true;

  /// 닉네임 체크 로딩
  bool _nicknameChecking = false;

  /// 비속어 체크
  Future<bool> _nickNameHasBadWords(String nickName) async {
    if (nickName == '') {
      if (context.mounted) {
        showCustomSnackBar(context, "닉네임을 1글자 이상 입력해주세요");
      }
      return true;
    }

    if (await hasBadWords(nickName)) {
      if (mounted) {
        showCustomSnackBar(context, "비속어, 연속적인 번호는 금지입니다.");
      }
      return true;
    }

    return false;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moveResult = ref.read(inGameMoveProvider);

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
          SizedBox(height: 5 * hu),
          Text(
            widget.reason == 0 ? '왕이 사망하였습니다.' : '한나라 기물의 수가 50을 초과하였습니다.',
            style: TextStyle(color: blackColor, fontSize: 10 * hu),
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
                    moveResult.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              const Text("수"),
            ],
          ),
          SizedBox(height: 30 * hu),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: "닉네임을 입력해주세요"),
            maxLength: 10,
            inputFormatters: [
              /// 한글 -> 천지인 키보드 아래아, 쌍아래아
              FilteringTextInputFormatter.allow(
                RegExp(
                  r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ| ]',
                ),
              ),
              // 영어와 숫자만 허용
            ],
          ),
          SizedBox(height: 30 * hu),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed:
                    _canRankRegister
                        ? () async {
                          try {
                            if (!_nicknameChecking) {
                              _nicknameChecking = true;
                              setState(() {});

                              final nickName = _textController.text;

                              if (await _nickNameHasBadWords(nickName)) {
                                _nicknameChecking = false;
                                setState(() {});
                                return;
                              }

                              await ref
                                  .read(rankProvider.notifier)
                                  .registerRank(
                                    rankModel: RankModel.autoId(
                                      move: moveResult,
                                      nickName: nickName,
                                    ),
                                  );

                              _canRankRegister = false;
                              _nicknameChecking = false;
                              setState(() {});
                              if (context.mounted) {
                                showCustomSnackBar(context, "랭킹에 등록하였습니다");
                              }
                            }
                          } catch (_) {
                            if (context.mounted) {
                              showCustomSnackBar(
                                context,
                                "랭킹 등록에 실패했습니다. 다시 시도해 주세요.",
                              );
                            }
                          }
                        }
                        : null,
                child:
                    _nicknameChecking
                        ? const Center(
                          child: CircularProgressIndicator(color: whiteColor),
                        )
                        : const Text("랭킹 등록"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: redColor),
                onPressed: () async {
                  final inGameGold = ref.read(inGameGoldProvider);

                  myGolds += inGameGold;

                  await GoldRepository().setGolds(golds: myGolds);

                  await InGameSavedDataRepository().removeInGameData();

                  if (context.mounted) {
                    Navigator.pop(globalContext!);
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
