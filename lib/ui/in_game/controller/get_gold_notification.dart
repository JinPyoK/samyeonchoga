import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/core/constant/color.dart';

part 'get_gold_notification.g.dart';

@Riverpod()
final class GetGoldNotificationWidget extends _$GetGoldNotificationWidget {
  @override
  Widget build() {
    return Container();
  }

  void showGoldNotification(bool isIncrease, int getGold) {
    state = _GoldNotification(
        key: GlobalKey(), increase: isIncrease, gold: getGold);
  }
}

class _GoldNotification extends StatefulWidget {
  const _GoldNotification(
      {required super.key, required this.increase, required this.gold});

  final bool increase;
  final int gold;

  @override
  State<_GoldNotification> createState() => _GoldNotificationState();
}

class _GoldNotificationState extends State<_GoldNotification> {
  double _goldOpacity = 1;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      _goldOpacity = 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _goldOpacity,
      duration: const Duration(seconds: 1),
      child: Text(
        '${widget.increase ? '+' : '-'} ${widget.gold}',
        style: const TextStyle(color: whiteColor),
      ),
    );
  }
}
