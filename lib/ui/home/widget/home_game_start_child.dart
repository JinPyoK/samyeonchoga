import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/in_game/in_game_gold_provider.dart';
import 'package:samyeonchoga/provider/lineup/lineup.dart';
import 'package:samyeonchoga/repository/gold/gold_repository.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';
import 'package:samyeonchoga/ui/common/screen/home_navigation_screen.dart';
import 'package:samyeonchoga/ui/common/widget/image_assets.dart';
import 'package:samyeonchoga/ui/in_game/screen/in_game_screen.dart';

class HomeGameStartChild extends ConsumerStatefulWidget {
  const HomeGameStartChild({super.key});

  @override
  ConsumerState<HomeGameStartChild> createState() => _HomeGameStartChildState();
}

class _HomeGameStartChildState extends ConsumerState<HomeGameStartChild> {
  int _startGold = 0;

  GestureDetector _renderLineup(Lineup selectedLineup) {
    late ImageProvider lineup1;
    late ImageProvider lineup2;
    late ImageProvider lineup3;
    late ImageProvider lineup4;

    late String label1;
    late String label2;
    late String label3;
    late String label4;

    switch (selectedLineup) {
      case Lineup.maSangMaSang:
        lineup1 = imageBlueMa;
        lineup2 = imageBlueSang;
        lineup3 = imageBlueMa;
        lineup4 = imageBlueSang;
        label1 = '마';
        label2 = '상';
        label3 = '마';
        label4 = '상';
        break;

      case Lineup.sangMaSangMa:
        lineup1 = imageBlueSang;
        lineup2 = imageBlueMa;
        lineup3 = imageBlueSang;
        lineup4 = imageBlueMa;
        label1 = '상';
        label2 = '마';
        label3 = '상';
        label4 = '마';
        break;

      case Lineup.maSangSangMa:
        lineup1 = imageBlueMa;
        lineup2 = imageBlueSang;
        lineup3 = imageBlueSang;
        lineup4 = imageBlueMa;
        label1 = '마';
        label2 = '상';
        label3 = '상';
        label4 = '마';
        break;

      default:
        lineup1 = imageBlueSang;
        lineup2 = imageBlueMa;
        lineup3 = imageBlueMa;
        lineup4 = imageBlueSang;
        label1 = '상';
        label2 = '마';
        label3 = '마';
        label4 = '상';
        break;
    }

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
                    Image(image: lineup1),
                    Text(label1, style: TextStyle(fontSize: 100 * hu)),
                  ],
                ),
                Column(
                  children: [
                    Image(image: lineup2),
                    Text(label2, style: TextStyle(fontSize: 100 * hu)),
                  ],
                ),
                Column(
                  children: [
                    Image(image: lineup3),
                    Text(label3, style: TextStyle(fontSize: 100 * hu)),
                  ],
                ),
                Column(
                  children: [
                    Image(image: lineup4),
                    Text(label4, style: TextStyle(fontSize: 100 * hu)),
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
  void initState() {
    super.initState();

    /// 게임 시작을 누르면 initState가 또 실행된다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myGolds > 3000 ? _startGold = 3000 : _startGold = myGolds;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "게임 시작 골드 (최대 3000골드)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                _startGold.toString(),
                style: TextStyle(fontSize: 25 * hu),
              ),
            ),
            SizedBox(width: 10 * wu),
            FaIcon(FontAwesomeIcons.coins, color: Colors.amber, size: 30 * hu),
          ],
        ),
        SizedBox(height: 15 * hu),
        Center(
          child: FittedBox(
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    _startGold = 0;
                    setState(() {});
                  },
                  child: const Text("최소"),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    _startGold <= 100 ? _startGold = 0 : _startGold -= 100;
                    setState(() {});
                  },
                  child: const Text("-100"),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    if (_startGold + 100 >= myGolds) {
                      _startGold = myGolds;
                    } else {
                      _startGold >= 2900
                          ? _startGold = 3000
                          : _startGold += 100;
                    }

                    setState(() {});
                  },
                  child: const Text("+100"),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    myGolds <= 3000 ? _startGold = myGolds : _startGold = 3000;

                    setState(() {});
                  },
                  child: const Text("최대"),
                ),
              ],
            ),
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
              _renderLineup(Lineup.maSangMaSang),
              _renderLineup(Lineup.sangMaSangMa),
              _renderLineup(Lineup.maSangSangMa),
              _renderLineup(Lineup.sangMaMaSang),
            ],
          ),
        ),
        SizedBox(height: 50 * hu),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const FittedBox(child: Text("취소")),
              ),
            ),
            SizedBox(width: 10 * wu),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  myGolds -= _startGold;

                  await GoldRepository().setGolds(golds: myGolds);

                  setStateGold!(() {});

                  ref
                      .read(inGameGoldProvider.notifier)
                      .setInGameGold(_startGold);

                  if (context.mounted) {
                    Navigator.of(context, rootNavigator: true).pop();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InGameScreen(gameHadSaved: false),
                      ),
                    );
                  }
                },
                child: const FittedBox(child: Text("게임 시작")),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
