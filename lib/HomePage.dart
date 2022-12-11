import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging/CreatePage.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController post = new TextEditingController();

  User? googleUser;
  bool heart = false;

  @override
  void initState() {
    super.initState();
    getUserData();
    googleUser?.reload();
  }

  getUserData() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print('User is signed in!');
      this.googleUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram",
            style: TextStyle(
              color: Colors.black,
            )),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserPage(),
                  ));
            },
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(child: Text("HomePage")),
      )/*StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("UserData").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<UserData> userList = [];
          snapshot.data!.docs.toList().forEach((e) {
            Map values = e.data() as Map<String, dynamic>;
            // UserData(this.image,
            // this.uId, this.name,
            // this.email,
            // this.userImage,
            // this.id,
            // this.likes,
            // this.LikesUid);
            UserData user = UserData(
                values["image"] ?? "No image found",
                values["userUId"] ?? "No user uId found",
                values["userName"] ?? "No Name found",
                values["userEmail"] ?? "No email found",
                values["userImage"] ?? "No profile pic found",
                e.id,
                values["userLikes"] ?? 0,
                values["caption"] ?? "No cap");
            userList.add(user);
          });
          return ListView.builder(
            itemCount: userList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (c, i) {
              UserData user = userList[i];
              return Container(
                width: 100.w,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage("${user.userImage}"),
                        radius: 18,
                      ),
                      title: Text(
                        "${user.name}",
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                      subtitle: Text(
                        "${user.email}",
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      iconColor: Colors.black,
                      trailing: user.uId == googleUser?.uid
                          ? IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                var userData = FirebaseFirestore.instance
                                    .collection("UserData")
                                    .doc(user.id)
                                    .delete();
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  builder: (c) => Container(
                                    height: 40.h,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 0.5.h,
                                          width: 9.8.w,
                                          margin: EdgeInsets.only(top: 1.5.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black45),
                                        ),
                                        SizedBox(height: 2.h),
                                        Container(
                                          width: 100.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  "Why are you seeing this",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ), ListTile(
                                                title: Text(
                                                  "Add to favourites",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ), ListTile(
                                                title: Text(
                                                  "Hide",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ), ListTile(
                                                title: Text(
                                                  "Unfollow",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
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
                            ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      child: Image.network(
                        "${user.image}",
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 35.w,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        updateData(user.id);
                                      },
                                      icon: FaIcon(FontAwesomeIcons.heart),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    FaIcon(FontAwesomeIcons.comment),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Container(
                                        width: 6.5.w,
                                        height: 5.h,
                                        child: Image.asset("images/share.png")),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 55.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      "images/collection.webp",
                                      width: 8.5.w,
                                      height: 5.h,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 2.5.w),
                              Text("${user.likes} likes",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              SizedBox(width: 2.5.w),
                              SizedBox(
                                width: 41.5.h,
                                child: Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.black87),
                                      children: [
                                        TextSpan(
                                          text: "${user.name}  ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "${user.caption}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),*/
    );
  }

  Future<bool> getData(String id) async {
    bool val = false;
    QuerySnapshot docu = await FirebaseFirestore.instance
        .collection("UserData")
        .doc("${id}")
        .collection("Alluids")
        .get();
    docu.docs.forEach((element) {
      var Tdata = element.data() as Map<String, dynamic>;
      if (Tdata["${googleUser?.uid}"] != null) {
        val = true;
      }
    });
    return val;
  }

  updateData(String id) async {
    bool val2 = false;
    User? user = googleUser;

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("UserData")
        .doc("${id}")
        .get() as DocumentSnapshot<Object?>;
    var data = doc.data() as Map<String, dynamic>;

    QuerySnapshot docu = await FirebaseFirestore.instance
        .collection("UserData")
        .doc("${id}")
        .collection("Alluids")
        .get();
    docu.docs.forEach((element) {
      var Tdata = element.data() as Map<String, dynamic>;
      if (Tdata["${user?.uid}"] != null) {
        val2 = true;
      }
    });

    if (val2) {
      FirebaseFirestore.instance
          .collection("UserData")
          .doc("${id}")
          .collection("Alluids")
          .get()
          .then((subCollection) {
        subCollection.docs.forEach((doc) {
          var data3 = doc.data() as Map<String, dynamic>;
          if (data3["${user?.uid}"] != null) {
            Map<String, dynamic> map = {
              "userLikes": --data["userLikes"],
            };
            FirebaseFirestore.instance
                .collection("UserData")
                .doc("${id}")
                .update(map);

            doc.reference.delete();
          }
        });
      });
    } else {
      Map<String, dynamic> map = {
        "userLikes": ++data["userLikes"],
      };
      FirebaseFirestore.instance
          .collection("UserData")
          .doc("${id}")
          .update(map);
      Map<String, dynamic> map1 = {
        "${user?.uid}": true,
      };
      FirebaseFirestore.instance
          .collection('UserData')
          .doc("$id")
          .collection('Alluids')
          .add(map1);
    }
  }
}
