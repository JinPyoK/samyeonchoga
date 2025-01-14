import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/ui/audio/controller/sound_play.dart';
import 'package:samyeonchoga/ui/in_game/widget/system_notification/error_system_notification.dart';
import 'package:samyeonchoga/ui/in_game/widget/system_notification/janggoon_system_notification.dart';
import 'package:samyeonchoga/ui/in_game/widget/system_notification/red_on_the_ropes_system_notification.dart';
import 'package:samyeonchoga/ui/in_game/widget/system_notification/red_upgrade_system_notification.dart';

part 'in_game_system_notification_provider.g.dart';

@Riverpod()
final class InGameSystemNotification extends _$InGameSystemNotification {
  @override
  List<Widget> build() {
    return <Widget>[];
  }

  void notifyJanggoon() {
    state = <Widget>[
      ...state,
      JanggoonSystemNotification(key: GlobalKey()),
    ];
    makeExecuteOrJanggoonSound();
  }

  void notifyRedUpgrade(int level) {
    state = <Widget>[
      ...state,
      RedUpgradeSystemNotification(key: GlobalKey(), level: level),
    ];
    makeGameStartSound();
  }

  void notifySystemError(String errorMessage) {
    state = <Widget>[
      ...state,
      ErrorSystemNotification(key: GlobalKey(), errorMessage: errorMessage),
    ];
    makeSystemErrorSound();
  }

  void notifyOnTheRopes() {
    state = <Widget>[
      ...state,
      RedOnTheRopesSystemNotification(key: GlobalKey()),
    ];
    makeGameStartSound();
  }

  void clearNotificationList() {
    state.clear();
  }
}
