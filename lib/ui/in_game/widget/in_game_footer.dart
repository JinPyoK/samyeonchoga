import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/common/widget/gold_widget.dart';

class InGameFooter extends ConsumerStatefulWidget {
  const InGameFooter({super.key});

  @override
  ConsumerState<InGameFooter> createState() => _InGameFooterState();
}

class _InGameFooterState extends ConsumerState<InGameFooter> {
  ElevatedButton _renderSpawnButton(String imagePath, String label, int gold) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(fixedSize: Size(100, 50 * hu)),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(imagePath),
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

  @override
  Widget build(BuildContext context) {
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            Image.asset(imageRedChaPath),
                            const SizedBox(width: 10),
                            const Text(
                              "차",
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () {
                          showCustomDialog(
                            context,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  "게임을 종료하시겠습니까?\n\n게임을 저장하지 않으면 남은 골드는 돌려받습니다.",
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
                                _renderSpawnButton(
                                  imageRedChaPath,
                                  '차',
                                  130,
                                ),
                                const SizedBox(height: 10),
                                _renderSpawnButton(
                                  imageRedPoPath,
                                  '포',
                                  70,
                                ),
                                const SizedBox(height: 10),
                                _renderSpawnButton(
                                  imageRedMaPath,
                                  '마',
                                  50,
                                ),
                                const SizedBox(height: 10),
                                _renderSpawnButton(
                                  imageRedSangPath,
                                  '상',
                                  30,
                                ),
                                const SizedBox(height: 10),
                                _renderSpawnButton(
                                  imageRedSaPath,
                                  '사',
                                  30,
                                ),
                                const SizedBox(height: 10),
                                _renderSpawnButton(
                                  imageRedByungPath,
                                  '병',
                                  20,
                                ),
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
                      onPressed: () {}, child: const Text("기물 처형")),
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
