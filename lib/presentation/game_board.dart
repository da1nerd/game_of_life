import 'package:flutter/material.dart';
import 'package:game_of_life/domain/game_engine.dart';
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
  final _gameEngine = GameEngine();

  @override
  void initState() {
    widget.gameController.addListener((reset) {
      final gridController = _gridController;
      if (gridController != null) {
        if (reset) {
          // clear game state
          gridController.reset();
        } else {
          final nextState = _gameEngine.compute(gridController.cells());
          gridController.loadState(nextState);
          gridController.update();
        }
      }
    });

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
    switch (widget.gameController.editMode()) {
      case EditMode.add:
        controller.activateCell(x, y);
        break;
      case EditMode.erase:
        controller.deactivateCell(x, y);
        break;
    }
    controller.update();
  }
}
