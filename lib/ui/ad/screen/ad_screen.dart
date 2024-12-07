import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:samyeonchoga/ui/ad/widget/ad_banner.dart';
import 'package:samyeonchoga/ui/common/controller/scrren_size.dart';

class AdScreen extends StatelessWidget {
  const AdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              "광고",
              style: TextStyle(
                fontSize: 36 * hu,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Column(
            children: [
              AdBanner(),
              AdBanner(),
              AdBanner(),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10 * hu),
            child: ElevatedButton(
              onPressed: () {
                log("보상형 광고 시청");
              },
              child: const Text("광고 시청 후 1000골드 획득"),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderCaution("골드는 유저 여러분의 스마트폰 또는 PC 기기에 종속됩니다."),
              _renderCaution("앱을 삭제하면 보유하고 있던 골드가 사라집니다."),
              _renderCaution("광고를 올바르게 시청하지 않은 경우 보상이 주어지지 않을 수 있습니다."),
            ],
          )
        ],
      ),
    );
  }
}

Padding _renderCaution(String text) => Padding(
      padding: EdgeInsets.all(5 * hu),
      child: Text(
        "* $text",
        style: const TextStyle(color: Colors.black54),
      ),
    );
