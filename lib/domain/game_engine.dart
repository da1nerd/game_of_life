import 'dart:math';

import 'package:game_of_life/domain/cell.dart';

class GameEngine {
  List<List<bool>> compute(List<List<bool>> state) {
    return generateState(generateCells(state));
  }

  List<List<Cell>> generateCells(List<List<bool>> state) {
    final List<List<Cell>> cells = [];

    for (int y = 0; y < state.length; y++) {
      cells.add([]);
      for (int x = 0; x < state[y].length; x++) {
        final cellPosition = Point(x, y);
        var neighbors = 0;
        // top left
        neighbors +=
            _isCellAlive(state, cellPosition.y - 1, cellPosition.x - 1) ? 1 : 0;
        // top center
        neighbors +=
            _isCellAlive(state, cellPosition.y - 1, cellPosition.x) ? 1 : 0;
        // top right
        neighbors +=
            _isCellAlive(state, cellPosition.y - 1, cellPosition.x + 1) ? 1 : 0;
        // left center
        neighbors +=
            _isCellAlive(state, cellPosition.y, cellPosition.x - 1) ? 1 : 0;
        // right center
        neighbors +=
            _isCellAlive(state, cellPosition.y, cellPosition.x + 1) ? 1 : 0;
        // bottom left
        neighbors +=
            _isCellAlive(state, cellPosition.y + 1, cellPosition.x - 1) ? 1 : 0;
        // bottom center
        neighbors +=
            _isCellAlive(state, cellPosition.y + 1, cellPosition.x) ? 1 : 0;
        // bottom right
        neighbors +=
            _isCellAlive(state, cellPosition.y + 1, cellPosition.x + 1) ? 1 : 0;

        cells[y].add(Cell(_isCellAlive(state, y, x), neighbors));
      }
    }
    return cells;
  }

  List<List<bool>> generateState(List<List<Cell>> cells) {
    final List<List<bool>> state = [];

    for (int y = 0; y < cells.length; y++) {
      state.add([]);
      for (int x = 0; x < cells[y].length; x++) {
        state[y].add(cells[y][x].shouldLive());
      }
    }
    return state;
  }

  bool _isCellAlive(List<List<bool>> state, int y, int x) {
    if (y >= 0 && y < state.length) {
      if (x >= 0 && x < state[y].length) {
        return state[y][x];
      }
    }
    return false;
  }
}
