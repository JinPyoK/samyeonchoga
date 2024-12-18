import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'in_game_system_notification_provider.g.dart';

@Riverpod()
final class InGameSystemNotification extends _$InGameSystemNotification {
  @override
  List<dynamic> build() {
    return [];
  }

  void notifyJanggoon() {
    log("장군!!", name: 'notifyJanggoon');

    state.clear();

    state = [];
  }

  void notifyBlueUpgrade(int level) {
    log("초나라 알고리즘 $level 단계");

    state.clear();

    state = [];
  }

  void notifySystemError(String errorMessage) {
    log(errorMessage);

    state = [
      ...state,
      Container(),
    ];
  }
}
