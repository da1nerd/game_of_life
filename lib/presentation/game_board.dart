import 'package:flutter/material.dart';
import 'package:game_of_life/presentation/game_controller.dart';
import 'package:game_of_life/presentation/grid.dart';
import 'package:game_of_life/presentation/grid_controller.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    Key? key,
    required this.gameController,
    required this.cellSize,
  }) : super(key: key);

  final double cellSize;
  final GameController gameController;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  GridController? _gridController;

  @override
  void initState() {
    // TRICKY: get the view size after the first frame render
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final viewSize = context.size;
      if (viewSize is Size) {
        setState(() {
          _gridController = GridController(
            cellSize: widget.cellSize,
            gridSize: Size(
              viewSize.width,
              viewSize.height,
            ),
          );
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loadGrid();
  }

  Widget _loadGrid() {
    final controller = _gridController;
    if (controller != null) {
      return GestureDetector(
        onPanDown: (details) => _onTap(details.localPosition, controller),
        onPanUpdate: (details) => _onTap(details.localPosition, controller),
        child: Grid(
          controller: controller,
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  void _onTap(Offset tap, GridController controller) {
    final x = tap.dx ~/ controller.realCellSize.width;
    final y = tap.dy ~/ controller.realCellSize.height;
    controller.activateCell(x, y);
    controller.update();
  }
}
