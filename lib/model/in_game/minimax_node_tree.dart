/// 초나라 미니맥스 트리
/// 미니맥스 도중에는 초나라 기물이 부활하지 않음
final class MinimaxNodeTree {
  /// 전위 순회 방식의 깊이 우선 탐색(DFS)을 수행하면서 리프 노드에서 작업을 처리한 후 해당 리프 노드를 제거하는 방식이라면,
  /// 특정 시점에 트리의 특정 깊이에는 노드 하나만 존재한다.
  /// 루트 노드: minimaxNodes[0]
  /// 자식 노드: minimaxNodes[nodeDepth]
  /// 리프 노드: minimaxNodes[lastIndex]
  /// 자식 노드의 부모: minimaxNodes[nodeDepth - 1]

  final List<MinimaxNode> minimaxNodes = [];

  void addNode(MinimaxNode node) {
    minimaxNodes.add(node);
  }

  MinimaxNode? getParentNode(nodeDepth) {
    if (nodeDepth > 0) {
      return minimaxNodes[nodeDepth - 1];
    } else {
      return null;
    }
  }

  void removeLeafNode() {
    minimaxNodes.removeLast();
  }

  void nodesListClear() {
    minimaxNodes.clear();
  }
}

/// 초나라 미니맥스 알고리즘을 위한 미니맥스 노드 클래스
final class MinimaxNode {
  /// 노드의 타입 min(한) 또는 max(초)
  late MinimaxNodeType nodeType;

  /// 노드의 트리 깊이
  final int nodeDepth;

  /// 미니맥스 밸류 -> 최종 기물 선택 판단 값
  int? minimaxValue;

  /// 미니맥스 평가 밸류 -> 기물이 임의의 행마를 하였을 시점으로부터의 총 값
  int evaluationValue = 0;

  /// 노드가 선정한 기물의 x, y 좌표 -> 최종
  /// 적으로 inGameBoardStatus에서 getStatus()를 통해 기물 정보 가져오기
  int? pieceX;
  int? pieceY;

  /// 가치가 가장 높거나 낮은 액셔너블의 값
  int? targetX;
  int? targetY;
  int targetValue = 0;

  MinimaxNode({
    required this.nodeDepth,
  }) {
    nodeType =
        (nodeDepth + 1) % 2 == 1 ? MinimaxNodeType.max : MinimaxNodeType.min;
  }
}

enum MinimaxNodeType {
  min,
  max,
}