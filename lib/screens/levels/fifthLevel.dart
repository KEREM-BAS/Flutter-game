import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:deneme/configs/themeColor.dart';
import 'package:deneme/screens/finalScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({super.key});

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

var random = Random();
int randomNumber = random.nextInt(98) + 1;
double _activeSliderValue = 0;
bool disable = false;

class _FifthScreenState extends State<FifthScreen> {
  late ConfettiController _controllerCenter;
  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    super.dispose();
    _controllerCenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String auth = FirebaseAuth.instance.currentUser!.uid;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Leaderboard')
          .doc(auth)
          .snapshots(),
      builder: (context, snapshot) {
        var db = FirebaseFirestore.instance;
        var userDocument = snapshot.data;
        return Scaffold(
          backgroundColor: mainColor,
          body: SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ],
                ),
                Text(
                  'You need to get %$randomNumber',
                  style: TextStyle(
                    color: mainColor4,
                    fontSize: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: AbsorbPointer(
                    absorbing: disable,
                    child: SfSlider(
                      inactiveColor: mainColor2,
                      activeColor: mainColor3,
                      max: 100,
                      value: _activeSliderValue,
                      onChanged: (dynamic values) {
                        setState(() {
                          _activeSliderValue = values as double;
                        });
                      },
                      onChangeEnd: (value) {
                        int currentPoint = userDocument!['point'];
                        var val =
                            double.parse(value.toString().substring(0, 2));

                        setState(() {
                          disable = true;
                        });

                        if (val == randomNumber.toDouble()) {
                          _controllerCenter.play();
                          currentPoint = currentPoint + 1000;
                          db.collection('Leaderboard').doc(auth).set({
                            'point': currentPoint,
                          }, SetOptions(merge: true));
                        } else {
                          if ((val - randomNumber.toDouble()).abs() <= 3) {
                            currentPoint = currentPoint + 900;
                            db.collection('Leaderboard').doc(auth).set({
                              'point': currentPoint,
                            }, SetOptions(merge: true));
                          } else {
                            if ((val - randomNumber.toDouble()).abs() <= 7) {
                              currentPoint = currentPoint + 800;
                              db.collection('Leaderboard').doc(auth).set({
                                'point': currentPoint,
                              }, SetOptions(merge: true));
                            } else {
                              if ((val - randomNumber.toDouble()).abs() <= 12) {
                                currentPoint = currentPoint + 700;
                                db.collection('Leaderboard').doc(auth).set({
                                  'point': currentPoint,
                                }, SetOptions(merge: true));
                              } else {
                                if ((val - randomNumber.toDouble()).abs() <=
                                    20) {
                                  currentPoint = currentPoint + 600;
                                  db.collection('Leaderboard').doc(auth).set({
                                    'point': currentPoint,
                                  }, SetOptions(merge: true));
                                } else {
                                  if ((val - randomNumber.toDouble()).abs() <=
                                      30) {
                                    currentPoint = currentPoint + 500;
                                    db.collection('Leaderboard').doc(auth).set({
                                      'point': currentPoint,
                                    }, SetOptions(merge: true));
                                  } else {
                                    if ((val - randomNumber.toDouble()).abs() <=
                                        40) {
                                      currentPoint = currentPoint + 400;
                                      db
                                          .collection('Leaderboard')
                                          .doc(auth)
                                          .set({
                                        'point': currentPoint,
                                      }, SetOptions(merge: true));
                                    } else {
                                      if ((val - randomNumber.toDouble())
                                              .abs() <=
                                          50) {
                                        currentPoint = currentPoint + 300;
                                        db
                                            .collection('Leaderboard')
                                            .doc(auth)
                                            .set({
                                          'point': currentPoint,
                                        }, SetOptions(merge: true));
                                      } else {
                                        currentPoint = 0;
                                        db
                                            .collection('Leaderboard')
                                            .doc(auth)
                                            .set({
                                          'point': currentPoint,
                                        }, SetOptions(merge: true));
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                        Timer(
                          Duration(seconds: 5),
                          () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FinalPage(),
                              )),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
