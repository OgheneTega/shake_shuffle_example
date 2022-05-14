import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shake_shuffle_example/screens/login_page.dart';
import 'package:shake_shuffle_example/services/user_management.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _email;
  String? _password;
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _pword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Icon(Icons.create),
        title: Text("Create Your Account"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: _emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    onChanged: (val) {
                      setState(() {
                        _email = val;
                      });
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: "example@example.com",
                      label: Text("Email Address"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    obscureText: true,
                    controller: _pword,
                    keyboardType: TextInputType.visiblePassword,
                    autofocus: true,
                    onChanged: (val) {
                      setState(() {
                        _password = val;
                      });
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.remove_red_eye_sharp),
                      hintText: "password",
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _email!, password: _password!)
                        .then((signedInUser) {
                      UserManagement().storeNewUser(signedInUser.user, context);
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  child: Text("Sign Up"),
                ),
                SizedBox(height: 10),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(color: Colors.red)),
                      TextSpan(
                        text: " Sign in",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginPage()));
                          },
                      )
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
