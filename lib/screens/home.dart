import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 175,
            margin: const EdgeInsets.only(left: 24, right: 24, top: 20),
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage("assets/images/black.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Progress summary',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '15 Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 17),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    'Progress',
                    style: TextStyle(
                      color: Colors.white,
                      // fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '30%',
                    style: TextStyle(
                      color: Colors.white,
                      // fontSize: 15,
                    ),
                  ),
                ]),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 400,
                    height: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: 0.3,
                        backgroundColor: Color.fromARGB(255, 118, 115, 115),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
