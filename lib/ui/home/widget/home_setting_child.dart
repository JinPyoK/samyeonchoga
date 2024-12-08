import 'package:easy_debounce/easy_debounce.dart';
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
          value: soundSetting.volume,
          min: 0,
          max: 9,
          divisions: 9,
          activeColor: woodColor,
          inactiveColor: Colors.black45,
          onChanged: (value) {
            soundSetting.volume = value;
            setState(() {});

            EasyDebounce.debounce('soundSetting', const Duration(seconds: 1),
                () async {
              await soundSetting.writSoundVolume();
            });
          },
        )
      ],
    );
  }
}
