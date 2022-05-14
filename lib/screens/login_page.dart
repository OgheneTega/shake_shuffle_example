import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shake_shuffle_example/screens/home_page.dart';
import 'package:shake_shuffle_example/screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email;
  String? _password;
  GoogleSignIn googleAuth = GoogleSignIn();

  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _pword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Icon(Icons.login),
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextFormField(
                      controller: _emailAddress,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      validator: (String? email) {
                        if (_emailAddress.text.isEmpty) {
                          return "Email Address should not be empty";
                        }
                        return "";
                      },
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
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email!, password: _password!)
                            .then((user) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage()));
                        }).catchError((e) {
                          print(e);
                        });
                      },
                      style: ElevatedButton.styleFrom(elevation: 2.0),
                      child: Text("Login"),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        googleAuth.signIn().then((user) {
                          user!.authentication.then((googleKey) {
                            FirebaseAuth.instance
                                .signInWithCredential(
                                    GoogleAuthProvider.credential(
                                        idToken: googleKey.idToken,
                                        accessToken: googleKey.accessToken))
                                .then((signedInUser) {
                              print(
                                  "Signed in as ${signedInUser.user!.displayName.toString()}");
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage()));
                            }).catchError((e) {
                              print(e);
                            });
                          }).catchError((e) {
                            print(e);
                          });
                        }).catchError((e) {
                          print(e);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, elevation: 2.0),
                      child: Row(
                        children: [
                          Container(
                            child: Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                                fit: BoxFit.cover),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Login with Google",
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Don\'t have an account?",
                            style: TextStyle(color: Colors.red)),
                        TextSpan(
                          text: " Sign up",
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignUpPage()));
                            },
                        )
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
