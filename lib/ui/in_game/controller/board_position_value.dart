import 'dart:developer';

import 'package:samyeonchoga/model/in_game/board_position_enum.dart';

Map<BoardPositionX, double> boardPositionXValue = {
  BoardPositionX.x1: 0,
  BoardPositionX.x2: 0,
  BoardPositionX.x3: 0,
  BoardPositionX.x4: 0,
  BoardPositionX.x5: 0,
  BoardPositionX.x6: 0,
  BoardPositionX.x7: 0,
  BoardPositionX.x8: 0,
  BoardPositionX.x9: 0,
};

Map<BoardPositionY, double> boardPositionYValue = {
  BoardPositionY.y1: 0,
  BoardPositionY.y2: 0,
  BoardPositionY.y3: 0,
  BoardPositionY.y4: 0,
  BoardPositionY.y5: 0,
  BoardPositionY.y6: 0,
  BoardPositionY.y7: 0,
  BoardPositionY.y8: 0,
  BoardPositionY.y9: 0,
  BoardPositionY.y10: 0,
};

void initBoardPositionValue(
    {required double boardWidth, required double boardHeight}) {
  log('이미지 넓이: $boardWidth, 높이: $boardHeight');

  final xValue = boardWidth / 360;
  final yValue = boardHeight / 720;

  boardPositionXValue[BoardPositionX.x1] = xValue * 1;
  boardPositionXValue[BoardPositionX.x2] = xValue * 2;
  boardPositionXValue[BoardPositionX.x3] = xValue * 3;
  boardPositionXValue[BoardPositionX.x4] = xValue * 4;
  boardPositionXValue[BoardPositionX.x5] = xValue * 5;
  boardPositionXValue[BoardPositionX.x6] = xValue * 6;
  boardPositionXValue[BoardPositionX.x7] = xValue * 7;
  boardPositionXValue[BoardPositionX.x8] = xValue * 8;
  boardPositionXValue[BoardPositionX.x9] = xValue * 9;

  boardPositionYValue[BoardPositionY.y1] = yValue * 1;
  boardPositionYValue[BoardPositionY.y2] = yValue * 2;
  boardPositionYValue[BoardPositionY.y3] = yValue * 3;
  boardPositionYValue[BoardPositionY.y4] = yValue * 4;
  boardPositionYValue[BoardPositionY.y5] = yValue * 5;
  boardPositionYValue[BoardPositionY.y6] = yValue * 6;
  boardPositionYValue[BoardPositionY.y7] = yValue * 7;
  boardPositionYValue[BoardPositionY.y8] = yValue * 8;
  boardPositionYValue[BoardPositionY.y9] = yValue * 9;
  boardPositionYValue[BoardPositionY.y10] = yValue * 10;
}
