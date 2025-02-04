import 'package:just_audio/just_audio.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/repository/sound/sound_setting.dart';

Future<void> makePieceSpawnSound(PieceType pieceType) async {
  switch (pieceType) {
    case PieceType.cha:
      await _makeSound(soundSpawnChaPath);
    case PieceType.po:
      await _makeSound(soundSpawnPoPath);
    case PieceType.ma:
      await _makeSound(soundSpawnMaPath);
    case PieceType.sang:
      await _makeSound(soundSpawnSangPath);
    default:
      await _makeSound(soundSpawnZolPath);
  }
}

Future<void> makePieceKilledSound(Team team) async {
  switch (team) {
    case Team.red:
      await _makeSound(soundRedKilledPath);
    default:
      await _makeSound(soundBlueKilledPath);
  }
}

Future<void> makeGameStartSound() async {
  await _makeSound(soundGameStartPath);
}

Future<void> makePieceTapSound() async {
  await _makeSound(soundPieceTapPath);
}

Future<void> makePieceMoveSound() async {
  await _makeSound(soundPieceMovePath);
}

Future<void> makeSystemErrorSound() async {
  await _makeSound(soundBlueKilledPath);
}

Future<void> makeExecuteOrJanggoonSound() async {
  await _makeSound(soundExecuteJanggoonPath);
}

double _volume = 0.5;

Future<void> _makeSound(String soundPath) async {
  final player = AudioPlayer();

  await player.setAsset(soundPath);

  await player.setVolume(_volume);

  await player.seek(const Duration());

  await player.play();

  await player.stop();

  await player.dispose();
}

Future<void> soundInit() async {
  _volume = await SoundVolumeRepository().getSoundVolume();
}
