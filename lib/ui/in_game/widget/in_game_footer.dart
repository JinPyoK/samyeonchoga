import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_board_status.dart';
import 'package:samyeonchoga/provider/in_game/in_game_footer_spawn_piece_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_gold_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_move_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_navigator_provider.dart';
import 'package:samyeonchoga/provider/in_game/in_game_turn_provider.dart';
import 'package:samyeonchoga/repository/in_game/in_game_saved_data_repository.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';
import 'package:samyeonchoga/ui/common/widget/gold_widget.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

import '../../../repository/gold/gold_repository.dart' show GoldRepository;
import '../../common/screen/home_navigation_screen.dart' show myGolds;

class InGameFooter extends ConsumerStatefulWidget {
  const InGameFooter({super.key});

  @override
  ConsumerState<InGameFooter> createState() => _InGameFooterState();
}

class _InGameFooterState extends ConsumerState<InGameFooter> {
  ElevatedButton _renderSpawnButton(PieceType piece) {
    late ImageProvider imagePiece;
    late String label;
    late int gold;

    switch (piece) {
      case PieceType.cha:
        imagePiece = imageBlueCha;
        label = '차';
        gold = 130;
        break;
      case PieceType.po:
        imagePiece = imageBluePo;
        label = '포';
        gold = 70;
        break;
      case PieceType.ma:
        imagePiece = imageBlueMa;
        label = '마';
        gold = 50;
        break;
      case PieceType.sang:
        imagePiece = imageBlueSang;
        label = '상';
        gold = 30;
        break;
      case PieceType.sa:
        imagePiece = imageBlueSa;
        label = '사';
        gold = 30;
        break;
      default:
        imagePiece = imageBlueZol;
        label = '졸';
        gold = 20;
        break;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(fixedSize: Size(100, 50 * hu)),
      onPressed: () {
        ref
            .read(inGameFooterSpawnPieceProvider.notifier)
            .changeSpawnPiece(piece);
        Navigator.pop(context);
        ref.read(inGameNavigatorProvider.notifier).showSpawnNavigator();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: imagePiece),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          GoldWidget(gold: gold, goldTextColor: whiteColor),
        ],
      ),
    );
  }

  Widget _renderSpawnSelectedBox(PieceType piece) {
    late ImageProvider imagePiece;
    late String label;

    switch (piece) {
      case PieceType.cha:
        imagePiece = imageBlueCha;
        label = '차';
        break;
      case PieceType.po:
        imagePiece = imageBluePo;
        label = '포';
        break;
      case PieceType.ma:
        imagePiece = imageBlueMa;
        label = '마';
        break;
      case PieceType.sang:
        imagePiece = imageBlueSang;
        label = '상';
        break;
      case PieceType.sa:
        imagePiece = imageBlueSa;
        label = '사';
        break;
      default:
        imagePiece = imageBlueZol;
        label = '졸';
        break;
    }

    final isMyTurn = ref.watch(inGameTurnProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap:
            isMyTurn
                ? () {
                  ref
                      .read(inGameNavigatorProvider.notifier)
                      .showSpawnNavigator();
                }
                : null,
        child: SizedBox(
          height: 50 * hu,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: '부활 기물 선택',
              labelStyle: const TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: whiteColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: imagePiece),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedSpawnPiece = ref.watch(inGameFooterSpawnPieceProvider);
    final isMyTurn = ref.watch(inGameTurnProvider);

    return ColoredBox(
      color: inGameBlackColor,
      child: Padding(
        padding: EdgeInsets.all(10 * hu),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: _renderSpawnSelectedBox(selectedSpawnPiece)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: redColor,
                      ),
                      onPressed:
                          isMyTurn
                              ? () {
                                showCustomDialog(
                                  context,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        "게임을 종료하시겠습니까?\n\n게임을 저장하지 않고 종료하면 게임 중 남은 골드는 사라집니다.",
                                        style: TextStyle(
                                          color: blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final tempList = <String>[];

                                          final move = ref.read(
                                            inGameMoveProvider,
                                          );
                                          final inGameGold = ref.read(
                                            inGameGoldProvider,
                                          );
                                          final inGameSaveDataList =
                                              inGameBoardStatus
                                                  .refinePieceModelForSave();

                                          tempList.add(move.toString());
                                          tempList.add(inGameGold.toString());

                                          final saveDataList = [
                                            ...tempList,
                                            ...inGameSaveDataList,
                                          ];

                                          await InGameSavedDataRepository()
                                              .saveInGameData(
                                                inGameData: saveDataList,
                                              );

                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const FittedBox(
                                          child: Text("게임 저장 후 종료"),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                        ),
                                        onPressed: () async {
                                          final inGameGold = ref.read(
                                            inGameGoldProvider,
                                          );

                                          myGolds += inGameGold;

                                          await GoldRepository().setGolds(
                                            golds: myGolds,
                                          );

                                          await InGameSavedDataRepository()
                                              .removeInGameData();

                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }

                                          setStateGold!(() {});
                                        },
                                        child: const FittedBox(
                                          child: Text("저장하지 않고 종료"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actionButtonColor: Colors.grey,
                                );
                              }
                              : null,
                      child: const FittedBox(child: Text("게임 저장 및 종료")),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed:
                          isMyTurn
                              ? () {
                                showCustomDialog(
                                  context,
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        _renderSpawnButton(PieceType.cha),
                                        const SizedBox(height: 10),
                                        _renderSpawnButton(PieceType.po),
                                        const SizedBox(height: 10),
                                        _renderSpawnButton(PieceType.ma),
                                        const SizedBox(height: 10),
                                        _renderSpawnButton(PieceType.sang),
                                        const SizedBox(height: 10),
                                        _renderSpawnButton(PieceType.sa),
                                        const SizedBox(height: 10),
                                        _renderSpawnButton(PieceType.zol),
                                      ],
                                    ),
                                  ),
                                  color: Colors.transparent,
                                  actionButtonColor: Colors.grey,
                                );
                              }
                              : null,
                      child: const FittedBox(child: Text("기물 부활 목록")),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed:
                          isMyTurn
                              ? () {
                                ref
                                    .read(inGameNavigatorProvider.notifier)
                                    .showExecuteNavigator();
                              }
                              : null,
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("기물 처형"),
                            SizedBox(width: 10 * wu),
                            const GoldWidget(
                              gold: 300,
                              goldTextColor: whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Dummy containers for spaceBetween in row
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
