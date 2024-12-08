import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/rank/widget/rank_tile.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20 * wu),
              child: Text(
                "랭크",
                style: TextStyle(
                  fontSize: 36 * hu,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20 * wu),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: woodColor,
                ),
                padding: const EdgeInsets.all(5),
                width: 36 * hu,
                height: 36 * hu,
                child: const FittedBox(
                  child: Icon(Icons.refresh, color: whiteColor),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (_, index) {
              return RankTile(
                ranking: index + 1,
                round: 538,
                nickName: 'nickName',
              );
            },
          ),
        ),
      ],
    );
  }
}
