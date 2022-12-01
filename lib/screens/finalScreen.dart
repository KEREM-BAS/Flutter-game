// ignore_for_file: prefer_const_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/configs/themeColor.dart';
import 'package:deneme/screens/homePage.dart';
import 'package:flutter/material.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key});

  @override
  State<FinalPage> createState() => _FinalPageState();
}

final db = FirebaseFirestore.instance;

class _FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: db.collection('Leaderboard').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final userSnapshot = snapshot.data?.docs;
        if (userSnapshot!.isEmpty) {
          return const Text("no data");
        }
        return Container(
          color: mainColor,
          height: height,
          width: width,
          child: Stack(
            children: [
              ListView(
                children: snapshot.data!.docs.map((doc) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: width / 20,
                      right: width / 20,
                    ),
                    child: Card(
                        color: mainColor2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                doc.data()["name"].toString(),
                                style: TextStyle(
                                  color: mainColor3,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                doc.data()["point"].toString(),
                                style: TextStyle(
                                  color: mainColor3,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor2,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Text(
                            'Restart',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
