import 'package:flutter/material.dart';

class GridController {
  final Size gridSize;
  late int columns;
  late int rows;

  /// The actual physical size of a cell, this will be close to the specified [cellSize] but not exactly.
  /// This is necessary to account for precision loss when calculating integer columns and rows from the double [cellSize].
  late Size realCellSize;
  final List<VoidCallback> _listeners = [];
  late List<List<bool>> _cells;

  GridController({
    required double cellSize,
    required this.gridSize,
  }) {
    rows = gridSize.height ~/ cellSize;
    columns = gridSize.width ~/ cellSize;
    realCellSize = Size(
      gridSize.width / columns,
      gridSize.height / rows,
    );
    _cells = _emptyCells();
  }

  /// Returns the current state of the grid.
  List<List<bool>> cells() {
    return _cells;
  }

  /// Displays a cell on the grid
  void activateCell(int x, int y) {
    _cells[x][y] = true;
  }

  /// Hides a cell on the grid
  void deactivateCell(int x, int y) {
    _cells[x][y] = false;
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
    _cells = _emptyCells();
    update();
  }

  List<List<bool>> _emptyCells() => List<List<bool>>.generate(
        columns,
        (_) => [
          ...List<bool>.filled(rows, false),
        ],
      );

  /// Loads a whole set of cells for the entire grid.
  void loadState(List<List<bool>> nextState) {
    _cells = nextState;
  }
}
