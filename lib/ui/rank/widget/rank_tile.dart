import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class RankTile extends StatelessWidget {
  const RankTile({
    super.key,
    required this.ranking,
    required this.round,
    required this.nickName,
  });

  final int ranking;
  final int round;
  final String nickName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 12 * hu, horizontal: 12 * wu),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 30 * wu,
                    child: Text(
                      ranking.toString(),
                      style: TextStyle(fontSize: 15 * wu),
                    ),
                  ),
                  SizedBox(
                    width: 120 * wu,
                    height: 25 * hu,
                    child: FittedBox(
                      child: Text(
                        nickName,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (ranking == 1 || ranking == 2 || ranking == 3)
                    ..._renderTrophy(ranking),
                  SizedBox(
                    width: 40 * wu,
                    height: 20 * hu,
                    child: FittedBox(
                      child: Text(
                        round.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 5 * wu),
                  Text(
                    'round',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10 * wu),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _renderTrophy(int ranking) {
  Color trophyColor = const Color(0xffFFD700);

  if (ranking == 2) {
    trophyColor = const Color(0xffBBC6C9);
  } else if (ranking == 3) {
    trophyColor = const Color(0xffB68061);
  }

  return <Widget>[
    FaIcon(FontAwesomeIcons.trophy, color: trophyColor),
    SizedBox(width: 10 * wu),
  ];
}
