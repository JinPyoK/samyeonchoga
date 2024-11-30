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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange.shade200,
              Colors.orange.shade500,
            ],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "四 面 楚 歌",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 42 * hu,
                    ),
                  ),
                  Text(
                    "사 면 초 가",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 42 * hu,
                    ),
                  ),
                  SizedBox(height: 5 * hu),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 24,
                    ),
                    child: Text(
                      "사방에서 초나라 노래가 흘러나온다는 뜻으로, 사면이 모두 적에게 포위되거나, 누구의 지지나 도움도 받을 수 없어 고립된 상태를 이르는 말.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12 * hu,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200 * hu,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20 * wu),
                      child: Text(
                        "로그인을 진행해 주세요!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12 * hu,
                        ),
                      ),
                    ),

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
