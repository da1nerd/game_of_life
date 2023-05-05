import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final Color backgroundColor;
  final Color gridColor;
  final Color cellColor;
  final int columns;
  final int rows;
  final List<List<bool>> cells;

  GridPainter({
    required this.backgroundColor,
    required this.gridColor,
    required this.cellColor,
    required this.columns,
    required this.rows,
    required this.cells,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final lh = size.height / rows;
    final lw = size.width / columns;

    _drawBackground(size, canvas);
    _drawGrid(size, lh, lw, canvas);
    _drawCells(lh, lw, columns, rows, canvas);
  }

  bool _cellIsActive({required int x, required int y}) {
    return cells.length > x && cells[x].length > y && cells[x][y] == true;
  }

  void _drawCells(double lh, double lw, int columns, int rows, Canvas canvas) {
    const padding = 0;
    final paint = Paint()
      ..color = cellColor
      ..strokeCap = StrokeCap.round;

    Path cellsPath = Path();

    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < columns; x++) {
        final offset = Offset(x * lw + lw / 2, y * lh + lh / 2);

        if (_cellIsActive(x: x, y: y)) {
          cellsPath.addRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: offset,
                width: lw - padding,
                height: lh - padding,
              ),
              Radius.circular(padding.toDouble()),
            ),
          );
        }
      }
    }

    canvas.drawPath(cellsPath, paint);
  }

  void _drawBackground(Size size, Canvas canvas) {
    final paint = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);
  }

  void _drawGrid(Size size, double lh, double lw, Canvas canvas) {
    const stroke = 1;
    final paint = Paint()
      ..color = gridColor
      ..strokeCap = StrokeCap.round;

    for (double h = 0; h < size.height + stroke; h += lh) {
      Path linePath = Path();
      linePath.addRect(Rect.fromLTRB(
          0, h.toDouble() - stroke / 2, size.width, h.toDouble() + stroke / 2));
      canvas.drawPath(linePath, paint);
    }

    for (double w = 0; w < size.width + stroke; w += lw) {
      Path linePath = Path();
      linePath.addRect(Rect.fromLTRB(w.toDouble() - stroke / 2, 0,
          w.toDouble() + stroke / 2, size.height));
      canvas.drawPath(linePath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
