import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/provider/in_game/in_game_navigator_provider.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_app_bar.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_body.dart';
import 'package:samyeonchoga/ui/in_game/widget/in_game_footer.dart';

class InGameScreen extends ConsumerWidget {
  const InGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(inGameNavigatorProvider.notifier).clearNavigator();
      },
      child: const Scaffold(
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
      ),
    );
  }
}
