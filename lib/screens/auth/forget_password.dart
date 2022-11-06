
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:doctor_appointment/screens/auth/Login/login.dart';
import 'package:doctor_appointment/utils/global.dart';

import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/widgets/action_button.dart';
import 'package:doctor_appointment/widgets/alert_dialogue.dart';
import 'package:doctor_appointment/widgets/field_title.dart';
import 'package:doctor_appointment/widgets/fields.dart';
import 'package:page_transition/page_transition.dart';



class ForgetPassword extends StatefulWidget {
  const ForgetPassword({ Key? key }) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController searchTextEditingController =
      new TextEditingController();
  bool isLoading = true;
  QuerySnapshot? namee;
  String? userName;
  String? userPass;
 TextEditingController emailcontroller=TextEditingController();
  String? email = " ";
  String? password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // ignore: deprecated_member_use
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  
  Future<bool> backclose() async {
    // SystemNavigator.pop();
    navigatorKey.currentState!.pushReplacement(
                
                  PageTransition(
                      type: PageTransitionType.fade, child: LoginPage()));
    return true;
  }

  String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  
   if (value!.isEmpty) {
    return "Email is empty";
  }
  else if ( !regex.hasMatch(value))
    return 'Enter a Valid Email Address ';
  return null;
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
          },
   
      child: WillPopScope(
        onWillPop: backclose,
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
               
                children: [
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:22.0, top: 15),
                        child: IconButton(onPressed: (){
                          navigatorKey.currentState!.push( PageTransition(child: LoginPage(), 
                          type: PageTransitionType.fade,),
                                );
                        }, icon: Icon(Icons.arrow_back, color: Colors.grey.shade600, size: 30,)),
                      ),
                     
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: FieldTitle(
                        title: "Forgot",
                        textColor: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: FieldTitle(
                        title: "Password?",
                        textColor: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 35,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: ScreenWidth(context)*0.9,
                      child: Text("Don't worry it happens. Please enter the email address associated your account",
                      style: GoogleFonts.poppins(),
                      )),
               
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                                      controller: emailcontroller,
                                              // obscureText: obscureText!,
                                              decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                                      prefixIcon: Icon(Icons.email),
                                      labelText: "Email ID",
                                      labelStyle: GoogleFonts.poppins()
                        
                                        // suffixIcon: suffIcon
                                              ),
                                            validator: (value) => validateEmail(value),
                                              ),
                        ),
                      ),
                    const SizedBox(
                      height: 45,
                    ),
                     ActionButton(
                      actionChild: Icon(Icons.login),
                      title: "Submit",
                      ontap: (){
                          if(_formKey.currentState!.validate()){
                                   
                                        FirebaseAuth.instance
                                            .sendPasswordResetEmail(email: emailcontroller.text.trim())
                                            .then((signedInUser) {
                                          _firestore
                                              .collection('user')
                                              .doc(email)
                                              .set({
                                            'password': password,
                                          });
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return AlertDialogWidegt(
                                                title: "Forget password",
                                                desc: "Link is successfully sent to your Email.\nPlease Check Your Inbox",
                                                onTap:(){
                                                  navigatorKey.currentState!.push(
                  
                    PageTransition(
                        type: PageTransitionType.fade, child: LoginPage()));
                                                }
                                              );
                                              
                                            },
                      );}).catchError((e){
                       showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return AlertDialogWidegt(
                                                title: "Forget password",
                                                desc: "User not found",
                                                onTap:(){
                                                  navigatorKey.currentState!.pop();
                                                }
                                              );
                                              
                                            },
                      );
                      });
                     
                      
                      }
                      
                     
                      },
                     )
                    
                  ],
                ),
              ],
            
                      ),
            ),
        ),
      ),
    ));
  }
}