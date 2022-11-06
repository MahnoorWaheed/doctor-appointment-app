import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:doctor_appointment/screens/auth/Login/login.dart';

class AuthState extends StatefulWidget {
  @override
  _AuthStateState createState() => _AuthStateState();
}
class _AuthStateState extends State<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  void initState() {
    print('Initialiadingin main');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _auth.currentUser != null? _auth.currentUser!.emailVerified? HomePage() :
    LoginPage()
    : LoginPage();
  }
}