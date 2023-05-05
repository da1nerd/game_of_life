import 'package:flutter/material.dart';
import 'package:game_of_life/presentation/game_board.dart';
import 'package:game_of_life/presentation/game_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Life',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(
        title: 'Game of Life',
        cellSize: 20,
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.title,
    required this.cellSize,
  });

  final String title;
  final double cellSize;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late bool _paused;
  late bool _eraseMode;

  final _gameController = GameController(
    cycleDuration: const Duration(milliseconds: 150),
  );

  @override
  void initState() {
    _paused = _gameController.isPaused();
    _eraseMode = _gameController.editMode() == EditMode.erase;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              if (_paused) {
                _gameController.start();
              } else {
                _gameController.stop();
              }
              setState(() {
                _paused = !_paused;
              });
            },
            icon: _paused
                ? const Icon(Icons.play_arrow)
                : const Icon(Icons.pause),
          ),
          IconButton(
            onPressed: () {
              if (_eraseMode) {
                _gameController.setEditMode(EditMode.add);
              } else {
                _gameController.setEditMode(EditMode.erase);
              }
              setState(() {
                _eraseMode = !_eraseMode;
              });
            },
            icon: _eraseMode
                ? const Icon(Icons.edit)
                : const Icon(Icons.edit_square),
          ),
          IconButton(
            onPressed: () {
              _gameController.reset();
              setState(() {
                _paused = true;
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: GameBoard(
          gameController: _gameController,
          cellSize: widget.cellSize,
        ),
      ),
    );
  }
}
