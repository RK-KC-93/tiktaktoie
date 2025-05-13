import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tiktaktoie/constants.dart';

class Gamepage extends StatefulWidget {
  final Size screenSize;
  const Gamepage({super.key, required this.screenSize});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              for (int i = 0; i < 9; i++)
                GestureDetector(
                  onTap: () {
                    theInput(i);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: widget.screenSize.width * 0.3,
                    width: widget.screenSize.width * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        gridData(i),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  String gridData(i) {
    if (i < 3) {
      return theboard[0][i];
    } else if (i < 6) {
      return theboard[1][i - 3];
    } else if (i < 9) {
      return theboard[2][i - 6];
    } else {
      return 'error';
    }
  }

  void theInput(i) {
    if (i < 3) {
      if (theboard[0][i] == ' ') {
        setState(() {
          theboard[0][i] = turnOf;
          turnOf = turnOf == 'X' ? 'O' : 'X';
        });
      }
    } else if (i < 6) {
      if (theboard[1][i - 3] == ' ') {
        setState(() {
          theboard[1][i - 3] = turnOf;
          turnOf = turnOf == 'X' ? 'O' : 'X';
        });
      }
    } else if (i < 9) {
      if (theboard[2][i - 6] == ' ') {
        setState(() {
          theboard[2][i - 6] = turnOf;
          turnOf = turnOf == 'X' ? 'O' : 'X';
        });
      }
    }
    checkWin();
  }

  void checkWin() {
    // check rows
    for (int i = 0; i < 3; i++) {
      if (theboard[i][0] == theboard[i][1] &&
          theboard[i][1] == theboard[i][2] &&
          theboard[i][0] != ' ') {
        dialogBox(theboard[i][0]);
      }
    }
    //check columns
    for (int i = 0; i < 3; i++) {
      if (theboard[0][i] == theboard[1][i] &&
          theboard[1][i] == theboard[2][i] &&
          theboard[0][i] != ' ') {
        dialogBox(theboard[0][i]);
      }
    }

    // check diagonals
    if (theboard[0][0] == theboard[1][1] &&
        theboard[1][1] == theboard[2][2] &&
        theboard[0][0] != ' ') {
      dialogBox(theboard[0][0]);
    }

    // check reverse diagonals
    if (theboard[0][2] == theboard[1][1] &&
        theboard[1][1] == theboard[2][0] &&
        theboard[0][2] != ' ') {
      dialogBox(theboard[0][2]);
    }

    if (theboard[0][0] != ' ' &&
        theboard[0][1] != ' ' &&
        theboard[0][2] != ' ' &&
        theboard[1][0] != ' ' &&
        theboard[1][1] != ' ' &&
        theboard[1][2] != ' ' &&
        theboard[2][0] != ' ' &&
        theboard[2][1] != ' ' &&
        theboard[2][2] != ' ') {
      dialogBox('Draw');
    }
  }

  void dialogBox(winner) {
    showAdaptiveDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(
          child: Text(
            winner != 'Draw' ? '$winner\n is the winner' : '$winner',
            textAlign: TextAlign.center,
          ),
        ),
        content: Text('Do you want to play again?'),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  theboard = [
                    [' ', ' ', ' '],
                    [' ', ' ', ' '],
                    [' ', ' ', ' ']
                  ];
                  winner = '';
                });
                Navigator.pop(context);
              },
              child: const Text('Yes')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No')),
        ],
      ),
    );
  }
}
