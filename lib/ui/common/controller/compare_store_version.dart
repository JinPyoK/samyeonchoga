import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/store_url.dart';
import 'package:samyeonchoga/provider/store_version/store_version_provider.dart';
import 'package:samyeonchoga/ui/common/controller/screen_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> compareStoreVersionAndShowDialog(BuildContext context) async {
  final canUpdate = await compareVersionWithStoreUploadedVersion();

  if (canUpdate == null || canUpdate == false) {
    return;
  } else {
    if (context.mounted) {
      showCustomDialog(
        context,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("새로운 버전이 출시되었습니다!"),
            SizedBox(height: 10 * hu),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: const FittedBox(child: Text("취소")),
                  ),
                ),
                SizedBox(width: 10 * wu),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await launchUrlString(
                          Platform.isAndroid
                              ? androidPlayStoreUrl
                              : 'https://apps.apple.com/us/app/%EC%82%AC%EB%A9%B4%EC%B4%88%EA%B0%80-janggi-defense/id6742233042',
                        );
                      } catch (_, _) {
                        if (context.mounted) {
                          showCustomSnackBar(context, '웹사이트에 접속할 수 없습니다.');
                        }
                      }
                    },
                    child: const FittedBox(child: Text("업데이트")),
                  ),
                ),
              ],
            ),
          ],
        ),
        defaultAction: false,
      );
    }
  }
}
