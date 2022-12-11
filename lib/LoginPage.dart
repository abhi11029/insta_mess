import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messaging/NavigationPage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: signInWithGoogle,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    bool isSign = false;
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    if (googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      QuerySnapshot doc =
          await FirebaseFirestore.instance.collection("UserData").get();
      doc.docs.forEach((element) {
        var data = element.data() as Map<String, dynamic>;
        if (data["userUId"] == user.user?.uid) {
          isSign = true;
        }
      });

      if (isSign) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationPage(),
            ),
            (route) => false);
      } else {
        Map<String, dynamic> map = {
          "name": "${user.user?.displayName}",
          "userUId": "${user.user?.uid}",
          "userImage": "${user.user?.photoURL}",
          "userName": " ",
          "posts":0,
          "followers":0,
          "following":0,
        };
        FirebaseFirestore.instance.collection("UserData").add(map);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationPage(),
            ),
            (route) => false);
      }
    }
  }
}
