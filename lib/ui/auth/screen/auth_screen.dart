import 'dart:developer';

import 'package:auth_button_kit/auth_button_kit.dart';
import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/provider/auth/oauth_provider.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';
import 'package:samyeonchoga/ui/common/controller/show_custom_snackbar.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> socialLogin({required String vendor}) async {
      final errorCode = await oAuthLogin(vendor: vendor);

      if (context.mounted) {
        if (errorCode != null) {
          showCustomSnackBar(context, errorCode);
          return;
        } else {
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ), (route) => false);
          log(getUID().toString());
          log(getDisplayName().toString());
        }
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("사면초가"),
              SizedBox(
                height: 200 * hu,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /// 카카오 로그인
                    GestureDetector(
                      onTap: () async {
                        await socialLogin(vendor: 'kakao');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Image.asset(kakaoLoginPath),
                      ),
                    ),

                    /// 구글 로그인
                    AuthButton(
                      onPressed: (_) async {
                        await socialLogin(vendor: 'google');
                      },
                      brand: Method.google,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      fontWeight: FontWeight.bold,
                    ),

                    /// 애플 로그인
                    AuthButton(
                      onPressed: (_) async {
                        await socialLogin(vendor: 'apple');
                      },
                      brand: Method.apple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
