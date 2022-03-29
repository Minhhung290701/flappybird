import 'dart:async';
import 'package:flappy/bird.dart';
import 'package:flutter/material.dart';
import 'package:flappy/barriers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool gameHasStarted = false;
  static double BarrierXone = 1.5;
  double BarrierXtwo = BarrierXone + 1.21;
  double score = 0;
  double best = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;

        if (BarrierXone < -1.2) {
          BarrierXone += 2.2;
        } else {
          BarrierXone -= 0.03;
        }
      });

      setState(() {
        if (BarrierXtwo < -1.2) {
          BarrierXtwo += 2.2;
        } else {
          BarrierXtwo -= 0.03;
        }
      });
      if (birdYaxis > 1 ) {
        timer.cancel();
        _showDialog();
        gameHasStarted = false;
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('GAME OVER'),
            content: Text('SCORE: '),
            actions: <Widget>[
              TextButton(
                child: Text("Play Againt"),
                onPressed: (){
                  if(score > best) best = score;
                  initState();
                  setState(() {
                    gameHasStarted = false;
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.2),
                      child: gameHasStarted
                          ? Text("")
                          : Text(
                              "TAP TO PLAY",
                              style: TextStyle(color: Colors.white, fontSize: 30),
                            ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(BarrierXone, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(BarrierXone, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 100.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(BarrierXtwo, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(BarrierXtwo, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 100.0,
                      ),
                    ),
                  ],
                )),
            Container(
              height: 10,
              child: Image.asset("lib/images/grass.png"),
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SCORE",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "0",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "BEST",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "0",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
