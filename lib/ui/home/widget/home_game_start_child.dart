import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/gold/gold_entity.dart';
import 'package:samyeonchoga/provider/in_game/in_game_gold_provider.dart';
import 'package:samyeonchoga/provider/lineup/lineup.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/util_function.dart';
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
        lineup1 = imageRedMa;
        lineup2 = imageRedSang;
        lineup3 = imageRedMa;
        lineup4 = imageRedSang;
        label1 = '마';
        label2 = '상';
        label3 = '마';
        label4 = '상';
        break;

      case Lineup.sangMaSangMa:
        lineup1 = imageRedSang;
        lineup2 = imageRedMa;
        lineup3 = imageRedSang;
        lineup4 = imageRedMa;
        label1 = '상';
        label2 = '마';
        label3 = '상';
        label4 = '마';
        break;

      case Lineup.maSangSangMa:
        lineup1 = imageRedMa;
        lineup2 = imageRedSang;
        lineup3 = imageRedSang;
        lineup4 = imageRedMa;
        label1 = '마';
        label2 = '상';
        label3 = '상';
        label4 = '마';
        break;

      default:
        lineup1 = imageRedSang;
        lineup2 = imageRedMa;
        lineup3 = imageRedMa;
        lineup4 = imageRedSang;
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
                    Text(
                      label1,
                      style: TextStyle(fontSize: 100 * hu),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image(image: lineup2),
                    Text(
                      label2,
                      style: TextStyle(fontSize: 100 * hu),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image(image: lineup3),
                    Text(
                      label3,
                      style: TextStyle(fontSize: 100 * hu),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image(image: lineup4),
                    Text(
                      label4,
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
  void initState() {
    super.initState();

    /// 게임 시작을 누르면 addPostFrameCallback이 또 한번 실행됨
    /// 이유를 아직 모르겠음
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myGold.gold > 3000 ? _startGold = 3000 : _startGold = myGold.gold;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
                _startGold.toString(),
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
        Center(
          child: FittedBox(
            child: Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      _startGold = 0;
                      setState(() {});
                    },
                    child: const Text("최소")),
                const SizedBox(width: 10),
                OutlinedButton(
                    onPressed: () {
                      _startGold <= 100 ? _startGold = 0 : _startGold -= 100;
                      setState(() {});
                    },
                    child: const Text("-100")),
                const SizedBox(width: 10),
                OutlinedButton(
                    onPressed: () {
                      if (_startGold + 100 >= myGold.gold) {
                        _startGold = myGold.gold;
                      } else {
                        _startGold >= 2900
                            ? _startGold = 3000
                            : _startGold += 100;
                      }

                      setState(() {});
                    },
                    child: const Text("+100")),
                const SizedBox(width: 10),
                OutlinedButton(
                    onPressed: () {
                      myGold.gold <= 3000
                          ? _startGold = myGold.gold
                          : _startGold = 3000;

                      setState(() {});
                    },
                    child: const Text("최대")),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text("취소")),
            ElevatedButton(
                onPressed: () async {
                  myGold.addGold(-_startGold);

                  await myGold.writeGold();

                  setStateGold!(() {});

                  ref
                      .read(inGameGoldProvider.notifier)
                      .setInGameGold(_startGold);

                  if (context.mounted) {
                    Navigator.of(context, rootNavigator: true).pop();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const InGameScreen(gameHadSaved: false)));
                  }
                },
                child: const Text("게임 시작")),
          ],
        )
      ],
    );
  }
}
