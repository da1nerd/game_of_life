import 'package:flutter/material.dart';
import 'package:game_of_life/presentation/grid_controller.dart';
import 'package:game_of_life/presentation/grid_painter.dart';

class Grid extends StatefulWidget {
  const Grid({
    Key? key,
    required this.controller,
    this.cellColor = Colors.white,
    this.gridColor = Colors.white24,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  final GridController controller;
  final Color cellColor;
  final Color gridColor;
  final Color backgroundColor;

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  void initState() {
    // Listen for changes in grid state
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(
        backgroundColor: widget.backgroundColor,
        gridColor: widget.gridColor,
        cellColor: widget.cellColor,
        columns: widget.controller.columns,
        rows: widget.controller.rows,
        cells: widget.controller.cells,
      ),
      child: const SizedBox(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
