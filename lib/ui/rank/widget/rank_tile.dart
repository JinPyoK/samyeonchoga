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
                    width: 45 * hu,
                    child: Text(
                      ranking.toString(),
                      style: TextStyle(fontSize: 20 * hu),
                    ),
                  ),
                  SizedBox(
                    width: 120 * hu,
                    child: Text(
                      nickName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12 * hu),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (ranking == 1 || ranking == 2 || ranking == 3)
                    ..._renderTrophy(ranking),
                  Text(
                    round.toString(),
                    style: TextStyle(fontSize: 14 * hu),
                  ),
                  SizedBox(width: 5 * wu),
                  Text(
                    'round',
                    style: TextStyle(fontSize: 14 * hu),
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
  Color trophyColor = Colors.amber;

  if (ranking == 2) {
    trophyColor = Colors.grey;
  } else if (ranking == 3) {
    trophyColor = Colors.brown;
  }

  return <Widget>[
    FaIcon(FontAwesomeIcons.trophy, color: trophyColor),
    SizedBox(width: 10 * wu),
  ];
}
