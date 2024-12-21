import 'package:flutter/cupertino.dart';
import 'package:samyeonchoga/provider/store_version/store_version_provider.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_dialog.dart';

Future<void> compareStoreVersionAndShowDialog(BuildContext context) async {
  final canUpdate = await compareVersionWithStoreUploadedVersion();

  if (canUpdate == null || canUpdate == false) {
    return;
  } else {
    if (context.mounted) {
      showCustomDialog(context, const Center(child: Text("새로운 버전이 출시되었습니다!")));
    }
  }
}
