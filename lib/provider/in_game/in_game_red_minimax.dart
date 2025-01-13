part of 'in_game_turn_provider.dart';

int _minimaxTreeDepth = 3;

final _minimaxNodeTree = MinimaxNodeTree();

final _minimaxResult = <MinimaxNode>[];

/// 초나라 미니맥스 알고리즘 params: List[treeDepth, boardStatusFromJsonList(), nodeDepth]
/// return List[선정 기물 모델x, y, 액셔너블x, y, 타겟밸류]
List<int?> _minimax(List<dynamic> params) {
  /// 트리의 최종 깊이
  final treeDepth = params[0] as int;

  /// 상태 보드 Json 직렬화된 상태
  final statusJsonList = params[1] as List<Map<String, dynamic>>;

  /// 현재 노드의 깊이
  final nodeDepth = params[2] as int;

  /// Json을 다시 역직렬화 하여 상태 보드 만들기
  final minimaxStatusBoard = InGameBoardStatus()
    ..boardStatusFromJsonList(statusJsonList);

  /// 노드가 max이면 초, min이면 한 기물들 조사
  final pieceList = (nodeDepth + 1) % 2 == 1
      ? minimaxStatusBoard.getRedAll()
      : minimaxStatusBoard.getBlueAll();

  bool allPiecesHaveEmptyActionable = true;

  /// 기물과 그 기물에 대한 행마에 대하여 미니맥스 수행
  for (PieceBaseModel piece in pieceList) {
    /// 기물의 행마 조사
    piece.searchActionable(minimaxStatusBoard);

    if (piece.pieceActionable.isNotEmpty) {
      allPiecesHaveEmptyActionable = false;

      for (PieceActionableModel pieceActionable in piece.pieceActionable) {
        /// 노드를 생성한 후 트리에 추가
        final node = MinimaxNode(nodeDepth: nodeDepth);
        _minimaxNodeTree.addNode(node);

        /// 노드에 값 대입하기
        node.pieceX = piece.x;
        node.pieceY = piece.y;
        node.targetX = pieceActionable.targetX;
        node.targetY = pieceActionable.targetY;
        node.targetValue = pieceActionable.targetValue;
        node.evaluationValue = node.targetValue;

        if (nodeDepth == 0) {
          _minimaxResult.add(node);
        } else {
          final parentNode = _minimaxNodeTree.getParentNode(nodeDepth);

          /// 부모 노드의 평가값 +- 현재 노드의 평가값
          node.evaluationValue = (node.nodeType == MinimaxNodeType.min)
              ? parentNode!.evaluationValue + node.evaluationValue
              : parentNode!.evaluationValue - node.evaluationValue;
        }

        /// 트리의 마지막 -> 값을 정해야 하는 구간
        if (nodeDepth + 1 >= treeDepth) {
          node.minimaxValue = node.evaluationValue;
          _computeParentChild(node);
        }

        /// 트리 순회 중
        else {
          /// 기물 행마에 대한 각각의 새로운 상태 보드 생성
          final statusBoardAboutPieceActionable = InGameBoardStatus()
            ..boardStatusFromJsonList(statusJsonList);

          /// 상태 변경
          statusBoardAboutPieceActionable.changeStatus(
            piece.x,
            piece.y,
            PieceActionableModel(
              targetX: piece.x,
              targetY: piece.y,
              targetValue: 0,
            ),
          );

          final newPiece = piece.getNewPieceInstance();

          newPiece.x = pieceActionable.targetX;
          newPiece.y = pieceActionable.targetY;

          statusBoardAboutPieceActionable.changeStatus(
            pieceActionable.targetX,
            pieceActionable.targetY,
            newPiece,
          );

          /// 상태 변경 후 미니맥스 진행
          _minimax([
            treeDepth,
            statusBoardAboutPieceActionable.boardStatusToJsonList(),
            nodeDepth + 1,
          ]);
          _computeParentChild(node);
          if (node.nodeDepth > 1) {
            if (_alphaBetaPruning(
                _minimaxNodeTree.getParentNode(node.nodeDepth)!)) {
              return [];
            }
          }
        }
      }
    }
  }

  /// 기물이 없거나 기물은 있는데 취할 액션이 없을경우
  if (allPiecesHaveEmptyActionable == true) {
    if (nodeDepth + 1 >= treeDepth) {
      return [];
    } else {
      /// 노드를 생성한 후 트리에 추가
      final node = MinimaxNode(nodeDepth: nodeDepth);
      _minimaxNodeTree.addNode(node);
      if (nodeDepth == 0) {
        _minimaxResult.add(node);
      } else {
        final parentNode = _minimaxNodeTree.getParentNode(nodeDepth);

        node.evaluationValue = parentNode!.evaluationValue;
      }
      node.minimaxValue = 0;

      _minimax([
        treeDepth,
        minimaxStatusBoard.boardStatusToJsonList(),
        nodeDepth + 1
      ]);

      _computeParentChild(node);

      return [];
    }
  }

  if (nodeDepth == 0) {
    if (_minimaxResult.isEmpty) {
      return [];
    }

    final firstNode = _minimaxResult[0];

    int minimaxResultValue = firstNode.minimaxValue!;
    List<int?> minimaxResultNodes = [
      firstNode.pieceX,
      firstNode.pieceY,
      firstNode.targetX,
      firstNode.targetY,
      firstNode.targetValue,
    ];
    for (MinimaxNode resultNode in _minimaxResult) {
      if (minimaxResultValue < resultNode.minimaxValue!) {
        minimaxResultValue = resultNode.minimaxValue!;
        minimaxResultNodes = [
          resultNode.pieceX,
          resultNode.pieceY,
          resultNode.targetX,
          resultNode.targetY,
          resultNode.targetValue,
        ];
      }
    }

    return minimaxResultNodes;
  }

  return [];
}

void _computeParentChild(MinimaxNode node) {
  final parentNode = _minimaxNodeTree.getParentNode(node.nodeDepth);

  /// 부모 노드가 존재
  if (parentNode != null && node.minimaxValue != null) {
    if (parentNode.minimaxValue == null) {
      parentNode.minimaxValue = node.minimaxValue;
    }

    /// 부모 노드의 미니맥스 밸류가 존재
    else {
      /// 0이 아닌 수가 하나라도 있을 경우 기물 변화에 대한 정보가 있기 때문에 그 수를 올려보내야 한다.
      /// 부모 노드의 미니맥스 밸류가 0인데 자식 노드의 미니맥스 밸류가 0이 아니면 그 수가 선택되지 않는다.
      /// 0이 다른 값보다 크거나 작기 때문이다.
      /// 트리의 해당 깊이에서 값들이 모두 0이라면 0을 올려보내고, 다른 값이 있다면 다른 값을 우선 보낸다.
      if (parentNode.minimaxValue == 0 && node.minimaxValue != 0) {
        parentNode.minimaxValue = node.minimaxValue;
      }

      /// 부모 노드의 미니맥스 밸류와 자식 노드의 미니맥스 밸류가 모두 0이 아닐 시에만 비교한다.
      else if (parentNode.minimaxValue != 0 && node.minimaxValue != 0) {
        /// 부모 노드가 max 노드
        if (parentNode.nodeType == MinimaxNodeType.max) {
          if (parentNode.minimaxValue! < node.minimaxValue!) {
            parentNode.minimaxValue = node.minimaxValue;
          }
        }

        /// 부모 노드가 min 노드
        else {
          if (parentNode.minimaxValue! > node.minimaxValue!) {
            parentNode.minimaxValue = node.minimaxValue;
          }
        }
      }
    }
  }

  _minimaxNodeTree.removeLeafNode();
}

/// 가지 치기가 가능하면 true
bool _alphaBetaPruning(MinimaxNode node) {
  final parentNode = _minimaxNodeTree.getParentNode(node.nodeDepth);

  /// 널 체크
  if (parentNode != null &&
      parentNode.minimaxValue != null &&
      node.minimaxValue != null) {
    /// 부모의 노드와 자식 노드의 값이 둘다 0이 아닌 경우에만 가지치기를 수행한다.
    /// 둘 중 하나라도 0인 경우 다른 유효한 값이 있을 수 있기 때문이다.
    if (parentNode.minimaxValue != 0 && node.minimaxValue != 0) {
      /// 알파 가지치기
      /// MIN노드의 현재 값이 부모 노드(즉, MAX노드)가 현재 가지고 있는 값보다 작거나 같다면,
      /// MIN노드의 자식 노드들을 탐색해 볼 필요가 없다.
      if (node.nodeType == MinimaxNodeType.min) {
        if (node.minimaxValue! <= parentNode.minimaxValue!) {
          return true;
        }
      }

      /// 베타 가지치기
      /// MAX노드의 현재 값이 부모 노드(즉, MIN노드)의 값보다 크거나 같다면,
      /// 부모 노드의 값을 줄일 가능성이 전혀 없기 때문에 마찬가지 이유로 자식 노드를 더 이상 탐색해볼 필요가 없다.
      else {
        if (node.minimaxValue! >= parentNode.minimaxValue!) {
          return true;
        }
      }
    }
  }

  return false;
}
