import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/color.dart';

void showCustomDialog(BuildContext context, Widget customChild) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, a1, a2) => Container(),
    transitionDuration: const Duration(milliseconds: 100),
    transitionBuilder: (context, a1, a2, child) {
      return ScaleTransition(
        scale: a1,
        child: AlertDialog(
          backgroundColor: whiteColor,
          scrollable: true,
          content: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: customChild,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: whiteColor,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text("확인"),
            ),
          ],
        ),
      );
    },
  );
}
