// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:deneme/configs/themeColor.dart';
import 'package:deneme/screens/secondLevel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FirstLevel extends StatefulWidget {
  const FirstLevel({super.key});

  @override
  State<FirstLevel> createState() => _FirstLevelState();
}

var random = Random();
int randomNumber = random.nextInt(98) + 1;
double _activeSliderValue = 0;
bool disable = false;

class _FirstLevelState extends State<FirstLevel> {
  late ConfettiController _controllerCenter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerCenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserCredential userCredential =
        FirebaseAuth.instance.signInAnonymously() as UserCredential;
    CollectionReference users =
        FirebaseFirestore.instance.collection('Leaderboard');

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: users.doc(userCredential.user!.uid).get(),
      builder: (context, snapshot) {
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
                        var val =
                            double.parse(value.toString().substring(0, 2));

                        setState(() {
                          disable = true;
                        });

                        if (val == randomNumber.toDouble()) {
                          _controllerCenter.play();
                        } else {
                          if ((val - randomNumber.toDouble()).abs() <= 3) {
                          } else {
                            if ((val - randomNumber.toDouble()).abs() <= 7) {
                            } else {
                              if ((val - randomNumber.toDouble()).abs() <= 12) {
                              } else {
                                if ((val - randomNumber.toDouble()).abs() <=
                                    20) {
                                } else {
                                  if ((val - randomNumber.toDouble()).abs() <=
                                      30) {
                                  } else {
                                    if ((val - randomNumber.toDouble()).abs() <=
                                        40) {
                                    } else {
                                      if ((val - randomNumber.toDouble())
                                              .abs() <=
                                          50) {
                                      } else {
                                        print('puan Alamadınız');
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
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SecondLevel(),
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
