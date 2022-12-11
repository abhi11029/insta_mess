import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging/HomePage.dart';
import 'package:messaging/LoginPage.dart';
import 'package:messaging/NavigationPage.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Messaging',
          home: const MiddleSplash(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MiddleSplash extends StatefulWidget {
  const MiddleSplash({Key? key}) : super(key: key);

  @override
  State<MiddleSplash> createState() => _MiddleSplashState();
}

class _MiddleSplashState extends State<MiddleSplash> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
          isLoaded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateWhere: isLoaded,
      navigateRoute: const SplashPage(),
      backgroundColor: Colors.white,
      text: WavyAnimatedText(
        "Instagram",
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      imageSrc: "images/splash.png",
      //  displayLoading: false,
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'images/splash.png',
      animationDuration: Duration(seconds: 2),
      splashIconSize: 150,
      nextScreen: SplashPage(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }*/
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  checkUser() {
    User? user = FirebaseAuth.instance.currentUser;
    print("user:: ${user != null}");
    if (user != null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationPage(),
            ),
            (route) => false);
      });
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
