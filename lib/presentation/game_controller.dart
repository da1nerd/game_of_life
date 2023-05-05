import 'dart:async';

typedef TickCallback = void Function(bool reset);

enum EditMode { add, erase }

class GameController {
  Timer? _timer;
  EditMode _editMode = EditMode.add;
  final Duration cycleDuration;
  final List<TickCallback> _listeners = [];

  GameController({required this.cycleDuration});

  /// Indicates how the user can interact with the game.
  EditMode editMode() {
    return _editMode;
  }

  /// Pauses the game
  void stop() {
    final timer = _timer;
    if (timer != null) {
      timer.cancel();
    }
    _timer = null;
  }

  /// Restarts the game
  void start() {
    _timer = Timer.periodic(cycleDuration, (timer) {
      tick();
    });
    tick();
  }

  void reset() {
    stop();
    tick(reset: true);
  }

  bool isPaused() {
    return _timer == null;
  }

  void addListener(TickCallback listener) {
    _listeners.add(listener);
  }

  void tick({bool reset = false}) {
    for (var l in _listeners) {
      l.call(reset);
    }
  }

  void setEditMode(EditMode mode) {
    _editMode = mode;
  }
}
