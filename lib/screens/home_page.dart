import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shake_shuffle_example/screens/login_page.dart';
// import 'package:shake/shake.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // static const List<Color> colors = [
  //   Colors.red,
  //   Colors.orange,
  //   Colors.yellow,
  //   Colors.green,
  //   Colors.blue,
  //   Colors.indigo,
  //   Colors.purple
  // ];

  // Color bgColor = colors.first;
  // ShakeDetector? detector;

  // @override
  // void initState() {
  //   super.initState();

  //   detector = ShakeDetector.autoStart(
  //     onPhoneShake: () {
  //       final newBgColor = (List.of(colors)
  //             ..remove(bgColor)
  //             ..shuffle())
  //           .first;

  //       setState(() {
  //         this.bgColor = newBgColor;
  //       });
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   detector!.stopListening();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Icon(Icons.home),
          title: Text("Dashboard"),
        ),
        body: Container(
          padding: EdgeInsets.all(48),
          color: Colors.white,
          // bgColor,
          child: Center(
            child: Column(
              children: [
                Text(
                  "You are now logged in",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((user) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  child: Text("Logout"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                    primary: Colors.white,
                    // side: BorderSide(color: Colors.black)
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
