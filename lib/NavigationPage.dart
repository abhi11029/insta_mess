import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging/CreatePage.dart';
import 'package:messaging/HomePage.dart';
import 'package:messaging/NotificationPage.dart';
import 'package:messaging/ProfilePage.dart';
import 'package:messaging/SearchPage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  User? user;
  int _selectedIndex = 0;
  PersistentTabController? _controller;
  bool? _hideNavBar;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Searchpage(),
    NotificationPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    _controller = PersistentTabController();
    _hideNavBar = false;
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
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUserPage(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Icon(
                    Icons.home_filled,
                    color: Colors.black,
                    size: 25,
                  )
                : Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
            label: 'hi',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Icon(
                    Icons.search_sharp,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
            label: 'hi',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? FaIcon(FontAwesomeIcons.solidHeart, color: Colors.black)
                : FaIcon(FontAwesomeIcons.heart, color: Colors.black),
            label: 'hi',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? (user?.photoURL != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage("${user?.photoURL}"),
                        radius: 12,
                      )
                    : Icon(Icons.circle_outlined))
                : (user?.photoURL != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage("${user?.photoURL}"),
                        radius: 10,
                      )
                    : Icon(Icons.circle_outlined)),
            label: 'hi',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
