import 'package:flutter/material.dart';

class GridController {
  final double cellSize;
  final Size gridSize;
  late int columns;
  late int rows;
  /// The actual physical size of the cell, this will be close to the specified cellSize.
  late Size realCellSize;
  final List<VoidCallback> _listeners = [];
  late List<List<int>> cells;

  GridController({
    required this.cellSize,
    required this.gridSize,
  }) {
    rows = gridSize.height ~/ cellSize;
    columns = gridSize.width ~/ cellSize;
    realCellSize = Size(
      gridSize.width / columns,
      gridSize.height / rows,
    );
    cells = _emptyCells();
  }

  /// Displays a cell on the grid
  void activateCell(int x, int y) {
    cells[x][y] = 1;
  }

  /// Hides a cell on the grid
  void deactivateCell(int x, int y) {
    cells[x][y] = 0;
  }

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// Tells all the listeners they should re-build.
  void update() {
    for (var l in _listeners) {
      l.call();
    }
  }

  void reset() {
    cells = _emptyCells();
    update();
  }

  List<List<int>> _emptyCells() => List<List<int>>.generate(
        columns,
        (_) => [
          ...List<int>.filled(rows, 0),
        ],
      );
}
