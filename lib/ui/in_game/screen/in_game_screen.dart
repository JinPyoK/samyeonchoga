import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_app_bar.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_body.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_footer.dart';

class InGameScreen extends StatelessWidget {
  const InGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: InGameAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: InGameBody(),
          ),
          Expanded(
            flex: 1,
            child: InGameFooter(),
          ),
        ],
      ),
    );
  }
}
