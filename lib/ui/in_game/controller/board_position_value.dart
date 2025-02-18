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
  7: 1,
  8: 1,
  9: 1,
};

void initBoardPositionValue(
    {required double boardWidth, required double boardHeight}) {
  final xValue = boardWidth / 360;
  final yValue = boardHeight / 720;

  pieceSize = 40 * xValue;

  boardPositionXValue[0] = xValue * -0.8;
  boardPositionXValue[1] = xValue * 39.5;
  boardPositionXValue[2] = xValue * 79.7;
  boardPositionXValue[3] = xValue * 119.9;
  boardPositionXValue[4] = xValue * 160.2;
  boardPositionXValue[5] = xValue * 200.5;
  boardPositionXValue[6] = xValue * 240.6;
  boardPositionXValue[7] = xValue * 281;
  boardPositionXValue[8] = xValue * 321.2;

  boardPositionYValue[0] = yValue * 642.5;
  boardPositionYValue[1] = yValue * 571;
  boardPositionYValue[2] = yValue * 500;
  boardPositionYValue[3] = yValue * 427.5;
  boardPositionYValue[4] = yValue * 356;
  boardPositionYValue[5] = yValue * 284.5;
  boardPositionYValue[6] = yValue * 213;
  boardPositionYValue[7] = yValue * 141.5;
  boardPositionYValue[8] = yValue * 70;
  boardPositionYValue[9] = yValue * -2.5;

  boardPositionYValueForKing[7] = yValue * 138;
  boardPositionYValueForKing[8] = yValue * 67;
  boardPositionYValueForKing[9] = yValue * -3;
}
