part of 'sound_play.dart';

Future<void> initAudio() async {
  AudioCache.instance = AudioCache(prefix: 'assets/sound/');
}

Future<void> _makeSound(String soundPath) async {
  final player = AudioPlayer();

  await player.setVolume(soundSetting.volume);

  await player.play(AssetSource(soundPath));
}
