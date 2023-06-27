import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:queue_client/models/entity.dart';
import 'package:queue_client/screens/home.dart';
import 'package:queue_client/screens/login.dart';
import 'package:queue_client/screens/profile.dart';
import 'package:queue_client/screens/signup.dart';
import 'package:redux/redux.dart';

class SplashScreen extends StatefulWidget {
  bool isLoggedIn;
  SplashScreen({super.key, required this.isLoggedIn});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState(isLoggedIn: isLoggedIn);
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn;
  _SplashScreenState({required this.isLoggedIn});

  @override
  void initState() {
    super.initState();
    if (isLoggedIn) {
      navigateToScreen(HomeScreen());
    } else {
      navigateToScreen(LoginScreen());
    }
  }

  void navigateToScreen(screen) {
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (ctx) => screen)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      body: SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image(
                image: AssetImage("assets/q.png"),
                width: 200,
              ),
              SizedBox(
                height: 50,
              ),
              SpinKitPianoWave(
                color: Colors.white,
                size: 50.0,
              ),
            ]),
      ),
    );
  }
}
