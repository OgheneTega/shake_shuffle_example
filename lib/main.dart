import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:shake/shake.dart';
// import 'package:shake_shuffle_example/screens/home_page.dart';
import 'package:shake_shuffle_example/screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// SHA1: B0:3A:5C:81:02:2A:86:EC:61:EB:A8:BC:40:A5:0A:19:F9:AB:C9:07
//          SHA256: 05:C2:67:FE:D9:11:95:E1:2C:0B:09:C1:BF:19:BC:2D:0A:61:8C:E7:67:AD:C5:0B:5D:96:C7:42:35:EB:1D:34

class MyApp extends StatelessWidget {
  final String title = 'Shuffle Example';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: LoginPage(),
      );
}
