import 'package:audioplayers/audioplayers.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';
import 'package:samyeonchoga/provider/sound/sound_setting.dart';

part 'sound_configure.dart';

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
      await _makeSound(soundBlueKilledPath);
    default:
      await _makeSound(soundRedKilledPath);
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
  await _makeSound(soundRedKilledPath);
}

Future<void> makeExecuteOrJanggoonSound() async {
  await _makeSound(soundExecuteJanggoonPath);
}
