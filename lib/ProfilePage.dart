import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messaging/CreatePage.dart';
import 'package:messaging/LoginPage.dart';
import 'package:messaging/Settings.dart' as Settings;
import 'package:messaging/Settings.dart';
import 'package:sizer/sizer.dart';

import 'Modal/GoogleUser.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  var userData;

  @override
  void initState() {
    super.initState();
    UserData();
    getUserData();
  }

  UserData() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print('User is signed in!');
      this.user = user;
      setState(() {});
    });
  }

  void getUserData() {
    FirebaseFirestore.instance.collection("UserData").get().then((value) {
      value.docs.forEach((element) {
        // this.name, this.uId, this.userImage, this.userName, this.followers,this.following, this.posts
        var data = element.data() as Map<String, dynamic>;
        if (data["userUid"] == user?.uid) {
          userData = GoogleData(
              data["name"],
              data["userUId"],
              data["userImage"],
              data["userName"],
              data["followers"],
              data["following"],
              data["posts"]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userData != null ? "${userData.name}" : "",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                builder: (c) => Container(
                  height: 60.h,
                  child: Column(
                    children: [
                      Container(
                        height: 0.6.h,
                        width: 9.w,
                        margin: EdgeInsets.only(top: 1.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black45),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              minLeadingWidth: 2.w,
                              leading: Icon(Icons.settings),
                              title: Text(
                                "Settings",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                selectionColor: Colors.white,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Setting()),
                                );
                              },
                            ),
                            ListTile(
                              minLeadingWidth: 2.w,
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
                              minLeadingWidth: 2.w,
                              leading: Icon(Icons.punch_clock_outlined),
                              title: Text(
                                "Your activity",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                selectionColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 2.w,
                              leading: Icon(Icons.qr_code),
                              title: Text(
                                "QR code",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                selectionColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 2.w,
                              leading: Icon(Icons.save),
                              title: Text(
                                "Saved",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                selectionColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 2.w,
                              leading: Icon(Icons.list),
                              title: Text(
                                "Close Friends",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                selectionColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 2.w,
                              leading: Icon(Icons.star_border_outlined),
                              title: Text(
                                "Favourites",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                selectionColor: Colors.white,
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 2.w,
                              leading: Icon(Icons.switch_account_sharp),
                              title: Text(
                                "Discover People",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                selectionColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              child: user != null
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text("0"),
                                Text("Followers"),
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              backgroundImage:
                                  NetworkImage("${user?.photoURL}"),
                              radius: 45,
                            ),
                            Column(
                              children: [
                                Text("0"),
                                Text("Following"),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          user?.displayName != null
                              ? "${user?.displayName}\n"
                              : "",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    )
                  : CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
