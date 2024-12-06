import 'package:flutter/material.dart';
import 'package:samyeonchoga/provider/auth/oauth_provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: OutlinedButton(
            onPressed: () async {
              await oAuthLogout();
            },
            child: Text("로그아웃")));
  }
}
