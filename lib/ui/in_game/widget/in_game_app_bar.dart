import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/in_game/in_game_gold_provider.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/widget/gold_widget.dart';

class InGameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const InGameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inGameGold = ref.watch(inGameGoldProvider);

    return AppBar(
      backgroundColor: inGameBlackColor,
      leading: const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(color: whiteColor),
      ),
      centerTitle: true,
      title: const Text(
        '10',
        style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10 * wu),
          child: GoldWidget(gold: inGameGold, goldTextColor: whiteColor),
        ),
      ],
    );
  }
}
