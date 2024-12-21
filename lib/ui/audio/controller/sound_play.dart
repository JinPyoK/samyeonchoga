import 'package:audioplayers/audioplayers.dart';
import 'package:samyeonchoga/core/constant/asset_path.dart';
import 'package:samyeonchoga/model/in_game/piece_enum.dart';

part 'sound_configure.dart';

Future<void> makePieceSpawnSound(PieceType pieceType) async {
  switch (pieceType) {
    case PieceType.cha:
      await _spawnChaAudio.resume();
    case PieceType.po:
      await _spawnPoAudio.resume();
    case PieceType.ma:
      await _spawnMaAudio.resume();
    case PieceType.sang:
      await _spawnSangAudio.resume();
    default:
      await _spawnByungOrZolAudio.resume();
  }
}

Future<void> makePieceKilledSound(Team team) async {
  switch (team) {
    case Team.blue:
      await _blueKilledAudio.resume();
    default:
      await _redKilledAudio.resume();
  }
}

Future<void> makeGameStartSound() async {
  await _gameStartAudio.resume();
}

Future<void> makePieceTapSound() async {
  await _pieceTapAudio.resume();
}

Future<void> makePieceMoveSound() async {
  await _pieceMoveAudio.resume();
}

Future<void> makeSystemErrorSound() async {
  await _redKilledAudio.resume();
}

Future<void> makeExecuteOrJanggoonSound() async {
  await _executeOrJanggoonAudio.resume();
}
