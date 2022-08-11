import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Snack extends StatefulWidget {
  const Snack({Key? key}) : super(key: key);

  @override
  State<Snack> createState() => _SnackState();
}

class _SnackState extends State<Snack> {
  static List<int> snake_position = [45, 65, 85, 105, 125];
  static int numberOfSquares = 540;
  int numberInRow = 20;
  bool gameHasStarted = false;
  static var randomNumber = Random();
  int food = randomNumber.nextInt(numberOfSquares - 1);

  void generatedNewFood() {
    food = randomNumber.nextInt(numberOfSquares - 1);
  }

  void startGame() {
    gameHasStarted = true;
    snake_position = [45, 65, 85, 105, 125];
    const duration = Duration(milliseconds: 200);
    Timer.periodic(duration, (Timer timer) {
      updatesnake();
      if (gameOver()) {
        timer.cancel();
        showGameOverScreen();
      }
    });
  }

  var direction = 'down';

  void updatesnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snake_position.last > numberOfSquares - numberInRow) {
            snake_position
                .add(snake_position.last + numberInRow - numberOfSquares);
          } else {
            snake_position.add(snake_position.last + numberInRow);
          }
          break;
        case 'up':
          if (snake_position.last < numberOfSquares + numberInRow) {
            snake_position
                .add(snake_position.last - numberInRow + numberOfSquares);
          } else {
            snake_position.add(snake_position.last - numberInRow);
          }
          break;
        case 'left':
          if (snake_position.last % numberInRow == 0) {
            snake_position.add(snake_position.last - 1 + numberInRow);
          } else {
            snake_position.add(snake_position.last - 1);
          }
          break;
        case 'right':
          if ((snake_position.last + 1) % numberInRow == 0) {
            snake_position.add(snake_position.last + 1 - numberInRow);
          } else {
            snake_position.add(snake_position.last + 1);
          }
          break;
        default:
      }
      if (snake_position.last == food) {
        generatedNewFood();
      } else {
        snake_position.removeAt(0);
      }
    });
  }

  bool gameOver() {
    for (int i = 0; i < snake_position.length; i++) {
      int count = 0;
      for (int j = 0; j < snake_position.length; j++) {
        if (snake_position[i] == snake_position[j]) {
          count++;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void showGameOverScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('yous scor is ' + snake_position.length.toString()),
          actions: [
            MaterialButton(
              onPressed: () {
                startGame();
                Navigator.of(context).pop();
              },
              child: Text('play Again ?'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (direction != 'left' && details.delta.dx > 0) {
                      direction = 'right';
                    } else if (direction != 'right' && details.delta.dx > 0) {
                      direction = 'left';
                    }
                  },
                  onVerticalDragUpdate: (details) {
                    if (direction != 'up' && details.delta.dy > 0) {
                      setState(() {
                        direction = 'down';
                      });
                    } else if (direction != 'down' && details.delta.dy > 0) {
                      setState(() {
                        direction = 'up';
                      });
                    }
                  },
                  child: GridView.builder(
                      itemCount: numberOfSquares,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow,
                        mainAxisExtent: 25,
                        crossAxisSpacing: 0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (snake_position.contains(index)) {
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                        if (index == food) {
                          return Container(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: Colors.green,
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (gameHasStarted == false) {
                          startGame();
                        }
                      },
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
