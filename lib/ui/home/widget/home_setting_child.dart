import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:samyeonchoga/core/constant/color.dart';
import 'package:samyeonchoga/repository/sound/sound_setting.dart';

class HomeSettingChild extends StatefulWidget {
  const HomeSettingChild({super.key});

  @override
  State<HomeSettingChild> createState() => _HomeSettingChildState();
}

class _HomeSettingChildState extends State<HomeSettingChild> {
  double _volume = 0.5;

  Future<void> _initVolume() async {
    _volume = await SoundVolumeRepository().getSoundVolume();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initVolume();
    });
  }

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
          value: _volume,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          activeColor: woodColor,
          inactiveColor: Colors.black45,
          onChanged: (value) {
            _volume = value;
            setState(() {});

            EasyDebounce.debounce(
                'soundSetting', const Duration(milliseconds: 500), () async {
              /// 기기에 소리 저장 볼륨값 저장
              await SoundVolumeRepository().setSoundVolume(volume: _volume);
            });
          },
        )
      ],
    );
  }
}
