import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  User? user;
  String uploaded = " ";
  bool isUrl = false;
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print('User is signed in!');
      this.user = user;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              value: isUrl,
              onChanged: (bool? val) {
                if (isUrl != null) {
                  isUrl = isUrl == true ? isUrl = false : isUrl = true;
                  setState(() {});
                }
              },
              title: Text("Paste Url from Internet?"),
            ),
            isUrl == false
                ? ElevatedButton(
                    onPressed: () async {
                      XFile? file = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (file != null) {
                        print("${file.name}");
                        print("${file.path}");
                        Reference ref = FirebaseStorage.instanceFor(
                                bucket: "gs://messaging-a540b.appspot.com")
                            .ref()
                            .child('locker')
                            .child('/${file.name}');
                        final metadata = SettableMetadata(
                          contentType: 'image/jpeg',
                          customMetadata: {'picked-file-path': file.path},
                        );
                        UploadTask uploadTask =
                            ref.putFile(io.File(file.path), metadata);
                        uploadTask.whenComplete(() async {
                          String uploadedUrl =
                              await uploadTask.snapshot.ref.getDownloadURL();
                          uploaded = uploadedUrl;
                          print("uploadTask: ${uploadedUrl}");
                        });
                      }
                    },
                    child: Text("Select Image"),
                  )
                : Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: TextField(
                      controller: urlController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      onChanged: (String? v) {
                        uploaded = urlController.text;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Url",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
            ElevatedButton(
              onPressed: () async {
                if (uploaded != " ") {
                  Map<String, dynamic> map = {
                    "image": "${uploaded}",
                    "userName": "${user?.displayName}",
                    "userEmail": "${user?.email}",
                    "userUId": "${user?.uid}",
                    "userImage": "${user?.photoURL}",
                    "userLikes": 0,
                  };
                  FirebaseFirestore.instance
                      .collection("UserData")
                      .add(map)
                      .then((doc) async {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text("Upload post"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
