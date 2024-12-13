import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class InGameFooter extends ConsumerStatefulWidget {
  const InGameFooter({super.key});

  @override
  ConsumerState<InGameFooter> createState() => _InGameFooterState();
}

class _InGameFooterState extends ConsumerState<InGameFooter> {
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
                          labelStyle: const TextStyle(color: whiteColor),
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
                          Navigator.pop(context);
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
                      onPressed: () {}, child: const Text("기물 부활")),
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
