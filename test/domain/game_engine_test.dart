import 'package:flutter_test/flutter_test.dart';
import 'package:game_of_life/domain/cell.dart';
import 'package:game_of_life/domain/game_engine.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './game_engine_test.mocks.dart';

@GenerateMocks([Cell])
void main() {
  late GameEngine engine;

  setUp(() {
    engine = GameEngine();
  });

  // TODO: replace this with some real tests
  test(
    'an empty grid should remain empty',
    () async {
      final List<List<bool>> input = [];
      final result = engine.compute(input);
      expect(result, input);
    },
  );

  group('a living cell survives', () {
    test(
      'a living cell with two neighbors survives',
      () async {
        final c = Cell(true, 2);
        expect(c.shouldLive(), true);
      },
    );

    test(
      'a living cell with three neighbors survives',
      () async {
        final c = Cell(true, 3);
        expect(c.shouldLive(), true);
      },
    );
  });

  group('a living cell dies', () {
    test(
      'a living cell with no neighbors dies',
      () async {
        final c = Cell(true, 0);
        expect(c.shouldLive(), false);
      },
    );

    test(
      'a living cell with one neighbor dies',
      () async {
        final c = Cell(true, 1);
        expect(c.shouldLive(), false);
      },
    );

    test(
      'a living cell with four neighbors dies',
      () async {
        final c = Cell(true, 4);
        expect(c.shouldLive(), false);
      },
    );
  });

  group('dead cells', () {
    test(
      'a dead cell with three neighbors is alive',
      () async {
        final c = Cell(false, 3);
        expect(c.shouldLive(), true);
      },
    );

    test(
      'a dead cell with two neighbors remains dead',
      () async {
        final c = Cell(false, 2);
        expect(c.shouldLive(), false);
      },
    );

    test(
      'a dead cell with four neighbors remains dead',
      () async {
        final c = Cell(false, 4);
        expect(c.shouldLive(), false);
      },
    );
  });

  test(
    'converts a two dimensional boolean array into a two dimensional cell array',
    () async {
      final List<List<bool>> input = [
        [false, true, false],
        [false, true, true],
        [false, false, false],
      ];
      final result = engine.generateCells(input);
      final expected = [
        [Cell(false, 2), Cell(true, 2), Cell(false, 3)],
        [Cell(false, 2), Cell(true, 2), Cell(true, 2)],
        [Cell(false, 1), Cell(false, 2), Cell(false, 2)],
      ];
      expect(result, expected);
    },
  );

  test(
    'converts a two dimensional cell array into a two bool array',
    () async {
      // arrange
      final mockCell = MockCell();
      final input = [
        [mockCell]
      ];
      when(mockCell.shouldLive()).thenReturn(true);
      // act
      final result = engine.generateState(input);
      // assert
      final List<List<bool>> expected = [
        [true]
      ];
      expect(result, expected);
      verify(mockCell.shouldLive()).called(1);
    },
  );

  // test(
  //   'a dead cell with exactly three neighbors comes to life',
  //       () async {
  //         final List<List<bool>> input = [
  //           [false, true, false],
  //           [false, true, true],
  //           [false, false, false],
  //         ];
  //         final result = engine.compute(input);
  //         final List<List<bool>> expected = [
  //           [false, true, true],
  //           [false, true, true],
  //           [false, false, false],
  //         ];
  //         expect(result, expected);
  //
  //         ///
  //         ///
  //         ///
  //
  //
  //         final c = Cell(x: 1, y: 1, neighbors: 2);
  //         expect(c.isAlive(), true);
  //
  //         final c = Cell(x: 1, y: 1, neighbors: 3);
  //         expect(c.isAlive(), true);
  //
  //         final c = Cell(x: 1, y: 1, neighbors: 1);
  //         expect(c.isAlive(), false);
  //
  //         final c = Cell(x: 1, y: 1, neighbors: 4);
  //         expect(c.isAlive(), false);
  //   },
  // );

  // test(
  //   'a cell with two neighbors survives',
  //   () async {
  //     final List<List<bool>> input = [
  //       [false, true, false],
  //       [false, true, true],
  //       [false, false, false]
  //     ];
  //     final result = engine.compute(input);
  //     expect(result, input);
  //   },
  // );

  // test(
  //   'a cell with three neighbors survives',
  //   () async {
  //     // arrange
  //     // act
  //     // assert
  //   },
  // );
}
