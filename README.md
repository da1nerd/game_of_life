# Game of Life

A flutter implementation of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

All of the UI has been built and the game engine stubbed out in [./lib/domain/game_engine.dart](./lib/domain/game_engine.dart), so you can use this as a starting point to practice [Test Driven Development](http://www.butunclebob.com/ArticleS.UncleBob.TheThreeRulesOfTdd).

## Usage
The UI comes with some pre-built controls to help you play the game:

* play/pause the generation timelapse.
* add/erase cells.
* delete the game.

Cells can be manually changed by clicking/tapping on an are in the grid.
This can be done while the game is running or paused.

![Image](./images/demo.gif)

## Get Started
To get started, write a new test in [./test/domain/game_engine_test.dart](./test/domain/game_engine_test.dart).