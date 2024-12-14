double pieceSize = 50;

Map<int, double> boardPositionXValue = {
  0: 0,
  1: 0,
  2: 0,
  3: 0,
  4: 0,
  5: 0,
  6: 0,
  7: 0,
  8: 0,
};

Map<int, double> boardPositionYValue = {
  0: 0,
  1: 0,
  2: 0,
  3: 0,
  4: 0,
  5: 0,
  6: 0,
  7: 0,
  8: 0,
  9: 0,
};

/// 한나라 왕의 이미지만 y value 차이가 있음
Map<int, double> boardPositionYValueForKing = {
  0: 1,
  1: 1,
  2: 1,
};

void initBoardPositionValue(
    {required double boardWidth, required double boardHeight}) {
  final xValue = boardWidth / 360;
  final yValue = boardHeight / 720;

  pieceSize = 40 * xValue;

  boardPositionXValue[0] = xValue * 0.7;
  boardPositionXValue[1] = xValue * 39.7;
  boardPositionXValue[2] = xValue * 79.7;
  boardPositionXValue[3] = xValue * 119.7;
  boardPositionXValue[4] = xValue * 159.7;
  boardPositionXValue[5] = xValue * 199.7;
  boardPositionXValue[6] = xValue * 239.7;
  boardPositionXValue[7] = xValue * 279.7;
  boardPositionXValue[8] = xValue * 319.7;

  boardPositionYValue[0] = yValue * 4;
  boardPositionYValue[1] = yValue * 75;
  boardPositionYValue[2] = yValue * 146;
  boardPositionYValue[3] = yValue * 217;
  boardPositionYValue[4] = yValue * 288;
  boardPositionYValue[5] = yValue * 359;
  boardPositionYValue[6] = yValue * 430;
  boardPositionYValue[7] = yValue * 501;
  boardPositionYValue[8] = yValue * 572;
  boardPositionYValue[9] = yValue * 643;

  boardPositionYValueForKing[0] = yValue * 1;
  boardPositionYValueForKing[1] = yValue * 72;
  boardPositionYValueForKing[2] = yValue * 143.5;
}
