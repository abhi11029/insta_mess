import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messaging/LoginPage.dart';
import 'package:sizer/sizer.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            ListTile(
              minVerticalPadding: 20,
              minLeadingWidth: 25,
              leading: Icon(Icons.archive_outlined),
              title: Text(
                "Archive",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                selectionColor: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () {
                GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                        (route) => false);

              },
              child: Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}
