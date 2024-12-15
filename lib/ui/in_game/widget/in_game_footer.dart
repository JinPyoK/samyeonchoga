import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/in_game/in_game_footer_spawn_piece_provider.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/common/widget/gold_widget.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';

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
        imagePiece = imageRedCha;
        label = '차';
        gold = 130;
        break;
      case PieceType.po:
        imagePiece = imageRedPo;
        label = '포';
        gold = 70;
        break;
      case PieceType.ma:
        imagePiece = imageRedMa;
        label = '마';
        gold = 50;
        break;
      case PieceType.sang:
        imagePiece = imageRedSang;
        label = '상';
        gold = 30;
        break;
      case PieceType.sa:
        imagePiece = imageRedSa;
        label = '사';
        gold = 30;
        break;
      default:
        imagePiece = imageRedByung;
        label = '병';
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
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: imagePiece),
          const SizedBox(width: 10),
          Text(
            label,
            style:
                const TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
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
        imagePiece = imageRedCha;
        label = '차';
        break;
      case PieceType.po:
        imagePiece = imageRedPo;
        label = '포';
        break;
      case PieceType.ma:
        imagePiece = imageRedMa;
        label = '마';
        break;
      case PieceType.sang:
        imagePiece = imageRedSang;
        label = '상';
        break;
      case PieceType.sa:
        imagePiece = imageRedSa;
        label = '사';
        break;
      default:
        imagePiece = imageRedByung;
        label = '병';
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          log("기물 부활 내비게이터 생성: $label");
        },
        child: SizedBox(
          height: 50 * hu,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: '부활 기물 선택',
              labelStyle: const TextStyle(
                  color: whiteColor, fontWeight: FontWeight.bold),
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
                )
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

    return ColoredBox(
      color: inGameBlackColor,
      child: Padding(
        padding: EdgeInsets.all(10 * hu),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        onPressed: () {
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
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("게임 저장 후 종료")),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("저장하지 않고 종료")),
                              ],
                            ),
                            actionButtonColor: Colors.grey,
                          );
                        },
                        child: const Text("게임 저장 및 종료")),
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
                      onPressed: () {
                        showCustomDialog(
                          context,
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                _renderSpawnButton(PieceType.byung),
                              ],
                            ),
                          ),
                          color: Colors.transparent,
                          actionButtonColor: Colors.grey,
                        );
                      },
                      child: const Text("기물 부활")),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("기물 처형"),
                          GoldWidget(gold: 300, goldTextColor: whiteColor),
                        ],
                      )),
                )),
              ],
            ),
            // dummy containers
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
