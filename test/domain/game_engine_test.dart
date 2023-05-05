import 'package:flutter_test/flutter_test.dart';
import 'package:game_of_life/domain/game_engine.dart';

void main() {
  late GameEngine engine;

  setUp(() {
    engine = GameEngine();
  });

  // TODO: replace this with some real tests
  test(
    'raises an exception because the engine is not implemented',
    () async {
      final List<List<bool>> input = [];
      expect(() => engine.compute(input), throwsA(isA<UnimplementedError>()));
    },
  );
}
