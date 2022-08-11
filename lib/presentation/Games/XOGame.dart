import 'package:flutter/material.dart';

import '../../main.dart';

class Xo extends StatefulWidget {
  const Xo({Key? key}) : super(key: key);

  @override
  State<Xo> createState() => _XoState();
}

class _XoState extends State<Xo> {
  var cC = false;
  var cL = false;
  var cR = false;

  var tC = false;
  var tL = false;
  var tR = false;

  var bC = false;
  var bL = false;
  var bR = false;

  var cCO = false;
  var cLO = false;
  var cRO = false;

  var tCO = false;
  var tLO = false;
  var tRO = false;

  var bCO = false;
  var bLO = false;
  var bRO = false;

  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              main();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.redo),
          ),
        ],
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text('X O Game'),
      ),
      body: GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.black,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    width: 10,
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    width: 10,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.black,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 10,
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 10,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          print(count);
                          if (count % 2 == 0 && !tRO) {
                            tR = true;
                          } else {
                            tRO = true;
                          }
                          count++;
                        });
                      },
                      child: tR || tRO
                          ? Align(
                              alignment: const Alignment(0.84, -0.45),
                              child: tRO ? O() : X(),
                            )
                          : Container(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (count % 2 == 0 && !tCO) {
                            tC = true;
                          } else {
                            tCO = true;
                          }
                          count++;
                        });
                      },
                      child: tC || tCO
                          ? Align(
                              alignment: const Alignment(0, -0.45),
                              child: tCO ? O() : X(),
                            )
                          : Container(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (count % 2 == 0 && !tLO) {
                            tL = true;
                          } else {
                            tLO = true;
                          }
                          count++;
                        });
                      },
                      child: tL || tLO
                          ? Align(
                              alignment: const Alignment(-0.84, -0.45),
                              child: tLO ? O() : X(),
                            )
                          : Container(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (count % 2 == 0 && !cCO) {
                            cC = true;
                          } else {
                            cCO = true;
                          }
                          count++;
                        });
                      },
                      child: cC || cCO
                          ? Align(
                              alignment: const Alignment(0, 0),
                              child: cCO ? O() : X(),
                            )
                          : Container(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (count % 2 == 0 && !cLO) {
                            cL = true;
                          } else {
                            cLO = true;
                          }
                          count++;
                        });
                      },
                      child: cL || cLO
                          ? Align(
                              alignment: const Alignment(-0.84, 0),
                              child: cLO ? O() : X(),
                            )
                          : Container(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (count % 2 == 0 && !cRO) {
                            cR = true;
                          } else {
                            cRO = true;
                          }
                          count++;
                        });
                      },
                      child: cR || cRO
                          ? Align(
                              alignment: const Alignment(0.84, 0),
                              child: cRO ? O() : X(),
                            )
                          : Container(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (count % 2 == 0 && !bLO) {
                            bL = true;
                          } else {
                            bLO = true;
                          }
                          count++;
                        });
                      },
                      child: bL || bLO
                          ? Align(
                              alignment: const Alignment(-0.84, 0.45),
                              child: bLO ? O() : X(),
                            )
                          : Container(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (count % 2 == 0 && !bCO) {
                            bC = true;
                          } else {
                            bCO = true;
                          }
                          count++;
                        });
                      },
                      child: bC || bCO
                          ? Align(
                              alignment: const Alignment(0, 0.45),
                              child: bCO ? O() : X(),
                            )
                          : Container(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (count % 2 == 0 && !bRO) {
                            bR = true;
                          } else {
                            bRO = true;
                          }
                          count++;
                        });
                      },
                      child: bR || bRO
                          ? Align(
                              alignment: const Alignment(0.84, 0.45),
                              child: bRO ? O() : X(),
                            )
                          : Container(),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

//BR 0.84,0.45 ,, BC 0,0.45 ,, BL -0.84,0,45
//CR 0.84,0 ,, CC 0,0 ,, CL -0.84,0
//TR 0.84,-0.45 ,, TC 0,-0.45  ,, TL -0.84,-0.45
  Widget X() {
    return const Icon(
      Icons.close,
      size: 100,
    );
  }

  Widget O() {
    return const Icon(
      Icons.circle_outlined,
      size: 100,
    );
  }
}
