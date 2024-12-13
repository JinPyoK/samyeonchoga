import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/gold/gold_entity.dart';
import 'package:samyeonchoga/provider/in_game/in_game_gold_provider.dart';
import 'package:samyeonchoga/provider/lineup/lineup.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/in_game/screen/in_game_screen.dart';

class HomeGameStartChild extends ConsumerStatefulWidget {
  const HomeGameStartChild({super.key});

  @override
  ConsumerState<HomeGameStartChild> createState() => _HomeGameStartChildState();
}

class _HomeGameStartChildState extends ConsumerState<HomeGameStartChild> {
  GestureDetector _renderLineup(
      Lineup selectedLineup, List<String> imagePath, List<String> label) {
    return GestureDetector(
      onTap: () {
        lineup = selectedLineup;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
          color: lineup == selectedLineup ? woodColor : whiteColor,
        ),
        child: SizedBox(
          height: 50 * hu,
          width: 100 * wu,
          child: FittedBox(
            child: Row(
              children: [
                Column(
                  children: [
                    Image.asset(imagePath[0], fit: BoxFit.cover),
                    Text(
                      label[0],
                      style: TextStyle(fontSize: 100 * hu),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(imagePath[1], fit: BoxFit.cover),
                    Text(
                      label[1],
                      style: TextStyle(fontSize: 100 * hu),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(imagePath[2], fit: BoxFit.cover),
                    Text(
                      label[2],
                      style: TextStyle(fontSize: 100 * hu),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(imagePath[3], fit: BoxFit.cover),
                    Text(
                      label[3],
                      style: TextStyle(fontSize: 100 * hu),
                    ),
                  ],
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
    final inGameGold = ref.watch(inGameGoldProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("게임 시작 골드 (최대 3000골드)",
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 20 * hu),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(10 * hu),
              child: Text(
                inGameGold.toString(),
                style: TextStyle(fontSize: 25 * hu),
              ),
            ),
            SizedBox(width: 10 * wu),
            FaIcon(
              FontAwesomeIcons.coins,
              color: Colors.amber,
              size: 30 * hu,
            ),
          ],
        ),
        SizedBox(height: 15 * hu),
        FittedBox(
          child: Row(
            children: [
              OutlinedButton(
                  onPressed: () {
                    ref.read(inGameGoldProvider.notifier).setInGameGold(0);
                  },
                  child: const Text("최소")),
              const SizedBox(width: 10),
              OutlinedButton(
                  onPressed: () {
                    if (inGameGold <= 100) {
                      ref.read(inGameGoldProvider.notifier).setInGameGold(0);
                    } else {
                      ref
                          .read(inGameGoldProvider.notifier)
                          .setInGameGold(inGameGold - 100);
                    }
                    setState(() {});
                  },
                  child: const Text("-100")),
              const SizedBox(width: 10),
              OutlinedButton(
                  onPressed: () {
                    if (inGameGold + 100 >= myGold.gold) {
                      ref
                          .read(inGameGoldProvider.notifier)
                          .setInGameGold(myGold.gold);
                    } else {
                      if (inGameGold >= 2900) {
                        ref
                            .read(inGameGoldProvider.notifier)
                            .setInGameGold(3000);
                      } else {
                        ref
                            .read(inGameGoldProvider.notifier)
                            .setInGameGold(inGameGold + 100);
                      }
                    }
                  },
                  child: const Text("+100")),
              const SizedBox(width: 10),
              OutlinedButton(
                  onPressed: () {
                    if (myGold.gold <= 3000) {
                      ref
                          .read(inGameGoldProvider.notifier)
                          .setInGameGold(myGold.gold);
                    } else {
                      ref.read(inGameGoldProvider.notifier).setInGameGold(3000);
                    }
                  },
                  child: const Text("최대")),
            ],
          ),
        ),
        SizedBox(height: 30 * hu),
        const Text("포진 선택", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 15 * hu),
        Center(
          child: Wrap(
            spacing: 10 * wu,
            runSpacing: 10 * hu,
            children: [
              _renderLineup(
                Lineup.maSangMaSang,
                <String>[
                  imageRedMaPath,
                  imageRedSangPath,
                  imageRedMaPath,
                  imageRedSangPath,
                ],
                <String>[
                  '마',
                  '상',
                  '마',
                  '상',
                ],
              ),
              _renderLineup(
                Lineup.sangMaSangMa,
                <String>[
                  imageRedSangPath,
                  imageRedMaPath,
                  imageRedSangPath,
                  imageRedMaPath,
                ],
                <String>[
                  '상',
                  '마',
                  '상',
                  '마',
                ],
              ),
              _renderLineup(
                Lineup.maSangSangMa,
                <String>[
                  imageRedMaPath,
                  imageRedSangPath,
                  imageRedSangPath,
                  imageRedMaPath,
                ],
                <String>[
                  '마',
                  '상',
                  '상',
                  '마',
                ],
              ),
              _renderLineup(
                Lineup.sangMaMaSang,
                <String>[
                  imageRedSangPath,
                  imageRedMaPath,
                  imageRedMaPath,
                  imageRedSangPath,
                ],
                <String>[
                  '상',
                  '마',
                  '마',
                  '상',
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 50 * hu),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text("취소")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const InGameScreen()));
                },
                child: const Text("게임 시작")),
          ],
        )
      ],
    );
  }
}
