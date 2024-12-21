part of 'sound_play.dart';

final _spawnChaAudio = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
final _spawnPoAudio = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
final _spawnMaAudio = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
final _spawnSangAudio = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
final _spawnByungOrZolAudio = AudioPlayer()
  ..setPlayerMode(PlayerMode.lowLatency);

final _redKilledAudio = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
final _blueKilledAudio = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);

final _gameStartAudio = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
final _pieceMoveAudio = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
final _pieceTapAudio = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
final _executeOrJanggoonAudio = AudioPlayer()
  ..setPlayerMode(PlayerMode.lowLatency);

Future<void> initAudio() async {
  await _spawnChaAudio.setSource(AssetSource(soundSpawnChaPath));
  await _spawnPoAudio.setSource(AssetSource(soundSpawnPoPath));
  await _spawnMaAudio.setSource(AssetSource(soundSpawnMaPath));
  await _spawnSangAudio.setSource(AssetSource(soundSpawnSangPath));
  await _spawnByungOrZolAudio.setSource(AssetSource(soundSpawnZolPath));

  await _redKilledAudio.setSource(AssetSource(soundRedKilledPath));
  await _blueKilledAudio.setSource(AssetSource(soundBlueKilledPath));

  await _gameStartAudio.setSource(AssetSource(soundGameStartPath));
  await _pieceMoveAudio.setSource(AssetSource(soundPieceMovePath));
  await _pieceTapAudio.setSource(AssetSource(soundPieceTapPath));
  await _executeOrJanggoonAudio
      .setSource(AssetSource(soundExecuteJanggoonPath));
}

Future<void> changeAudioVolume(double volume) async {
  await _spawnChaAudio.setVolume(volume);
  await _spawnPoAudio.setVolume(volume);
  await _spawnMaAudio.setVolume(volume);
  await _spawnSangAudio.setVolume(volume);
  await _spawnByungOrZolAudio.setVolume(volume);

  await _redKilledAudio.setVolume(volume);
  await _blueKilledAudio.setVolume(volume);

  await _gameStartAudio.setVolume(volume);
  await _pieceMoveAudio.setVolume(volume);
  await _pieceTapAudio.setVolume(volume);
  await _executeOrJanggoonAudio.setVolume(volume);
}

Future<void> disposeAudio() async {
  await _spawnChaAudio.dispose();
  await _spawnPoAudio.dispose();
  await _spawnMaAudio.dispose();
  await _spawnSangAudio.dispose();
  await _spawnByungOrZolAudio.dispose();

  await _redKilledAudio.dispose();
  await _blueKilledAudio.dispose();

  await _gameStartAudio.dispose();
  await _pieceMoveAudio.dispose();
  await _pieceTapAudio.dispose();
  await _executeOrJanggoonAudio.dispose();
}
