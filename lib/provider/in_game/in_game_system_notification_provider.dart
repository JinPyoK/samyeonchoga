import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samyeonchoga/ui/in_game/widget/system_notification/blue_upgrade_system_notification.dart';
import 'package:samyeonchoga/ui/in_game/widget/system_notification/error_system_notification.dart';
import 'package:samyeonchoga/ui/in_game/widget/system_notification/janggoon_system_notification.dart';

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
  }

  void notifyBlueUpgrade(int level) {
    state = <Widget>[
      ...state,
      BlueUpgradeSystemNotification(key: GlobalKey(), level: level),
    ];
  }

  void notifySystemError(String errorMessage) {
    state = <Widget>[
      ...state,
      ErrorSystemNotification(key: GlobalKey(), errorMessage: errorMessage),
    ];
  }

  void clearNotificationList() {
    state.clear();
  }
}
