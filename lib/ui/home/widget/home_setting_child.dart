import 'package:flutter/material.dart';
import 'package:samyeonchoga/provider/auth/oauth_provider.dart';
import 'package:samyeonchoga/ui/auth/screen/auth_screen.dart';

class HomeSettingChild extends StatefulWidget {
  const HomeSettingChild({super.key});

  @override
  State<HomeSettingChild> createState() => _HomeSettingChildState();
}

class _HomeSettingChildState extends State<HomeSettingChild> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          await oAuthLogout();
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const AuthScreen(),
              ),
              (route) => false,
            );
          }
        },
        child: const Text("로그아웃"));
  }
}
