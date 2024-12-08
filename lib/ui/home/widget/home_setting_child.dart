import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/provider/sound/sound_setting.dart';

class HomeSettingChild extends StatefulWidget {
  const HomeSettingChild({super.key});

  @override
  State<HomeSettingChild> createState() => _HomeSettingChildState();
}

class _HomeSettingChildState extends State<HomeSettingChild> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "효과음",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Slider(
          value: volume,
          min: 0,
          max: 9,
          divisions: 9,
          activeColor: woodColor,
          inactiveColor: Colors.black45,
          onChanged: (value) {
            volume = value;
            setState(() {});
            log(volume.toString());
          },
        )
      ],
    );
  }
}
