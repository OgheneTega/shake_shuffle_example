import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shake_shuffle_example/screens/home_page.dart';

class UserManagement {
  storeNewUser(user, context) {
    FirebaseFirestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }).catchError((e) {
      print(e);
    });
  }
}
