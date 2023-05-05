import 'package:equatable/equatable.dart';

class Cell extends Equatable {
  /// The number of living neighboring cells.
  final int neighbors;

  /// Indicates that the cell is currently alive.
  final bool alive;

  const Cell(this.alive, this.neighbors);

  /// Indicates if the cell should be alive in the next generation.
  bool shouldLive() {
    return (alive && neighbors == 2) || neighbors == 3;
  }

  @override
  List<Object?> get props => [neighbors, alive];
}
