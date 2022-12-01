import 'package:deneme/configs/themeColor.dart';
import 'package:flutter/material.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key});

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mainColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: ListView(),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Restart"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
