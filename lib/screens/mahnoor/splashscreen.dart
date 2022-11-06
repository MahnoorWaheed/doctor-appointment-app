import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctor_appointment/screens/auth/Login/auth_state.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:flutter/services.dart' show SystemNavigator, rootBundle;
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? email='medicareminder@gmail.com';
  @override
  void initState() {
    // getUserData();
    
    Future.delayed(Duration(seconds: 3), () {
      
      Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: AuthState ()));
    });
   
    super.initState();
  }


  Future<bool> backclose() async {
    
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backclose,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 30.0,
                top: 30,
              ),
              child: Image.asset(
                "assets/Blue_Modern_Dentist_Logo__1_-removebg-preview.png",
              ),
            ),
            Positioned(
              // bottom: -250,
              // right: -20,
               bottom: -100,
               right: 0,
               left: 10,

              // bottom: -230,
              // left: -100,
              // right: -60,
              height: ScreenHeight(context) * 0.7,

              child: SvgPicture.asset(
                "assets/undraw_doctors_hwty.svg",
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  Center(
                //    child: Container(child: CircularProgressIndicator(
                //         color:Theme.of(context).appBarTheme.backgroundColor,
                //       ),),
                //  )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
