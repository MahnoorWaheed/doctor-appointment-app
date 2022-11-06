
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:doctor_appointment/screens/auth/Login/login.dart';
import 'package:doctor_appointment/utils/global.dart';
import 'package:doctor_appointment/widgets/alert_dialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';

class FirebaseProvider with ChangeNotifier{
    final googlesign=GoogleSignIn();
  GoogleSignInAccount? _user;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  GoogleSignInAccount get user=>_user!;
  FirebaseAuth _auth = FirebaseAuth.instance;
 
 var gender = 'Gender';
  var day;
  var year;
  var month;

   String ct_email = '';
  String ct_name = '';
  String ct_relation = '';
  String ct_gender = '';
  String patient='';

init(){

}
Future sendVerification()async{
  try {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();


  }on FirebaseAuthException catch(e){
   
    print('No user found for that email.');
  }
}
/////////////////////Create Account/////////////////
Future<Object?> createAccount(String name, String email, String password, String conPassword, BuildContext context) 
async {
  FirebaseAuth _auth = FirebaseAuth.instance;
String? token = await FirebaseMessaging.instance.getToken();
  try {
   UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);
    FirebaseFirestore.instance.collection('user').doc(_auth.currentUser!.email).set({
          'email': email,
          'name':name,
          'token': token,
          'gender': '',
          'updated_at': '',
          'deleted_at': '', 
          'created_at': FieldValue.serverTimestamp(),
          'uid': _auth.currentUser!.uid,
           'password': password,
           'status': '',
           'image':'',
           'caretaker_email':'',
          'caretaker_token':'',
          'date_of_birth':''
      });
notifyListeners();

sendVerification();
    return userCrendetial.user;
  } 
  on FirebaseException catch(e){
     if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    showDialog(context: context, builder: (context){
                          return AlertDialogWidegt(
                            title: 'Registration Failed',
                            desc: 'The account already exists for that email.',
                            onTap: () => Navigator.pop(context),
                          );
                          
                      
                        });
  }
  else if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
  }


}
/////////////////////create account end////////////////////////

///////////////////////////////Login///////////////////////////////////////
bool isLoading=false;
Future logIn(String email, String password, BuildContext context) async {
  
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
   String? token = await FirebaseMessaging.instance.getToken();
  try {
    isLoading=true;
     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
     FirebaseFirestore.instance.collection('user').doc(_auth.currentUser!.email)
     .update({
      'token':token
     });

    print("Login Sucessfull");
    _firestore
        .collection('user')
        .doc(_auth.currentUser!.email)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
    
} on FirebaseAuthException catch(e){
 if (e.code == 'user-not-found') {
  showDialog(context: context, builder: (context){
                          return AlertDialogWidegt(
                            title: "Login Failed",
                            desc: "Email not registered",
                            onTap: (){
                               navigatorKey.currentState!.pop(context);
                            },
                          );
                        });
                        print('No user found for that email.');
                      } 
else if (e.code == 'wrong-password') {
    showDialog(context: context, builder: (context){
                          return AlertDialogWidegt(
                            title: "Login Failed",
                            desc: "Wrong password.",
                            onTap: (){
                               navigatorKey.currentState!.pop(context);
                            },
                          );
                        });
    print('Wrong password provided for that user.');
  }
}

 catch (e) {
    print(e);
    return null;
  
  }
  
  
}

///////////////////////////////login End ///////////////////////////////////
///////////////////////////////Logout/////////////////////////////
Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      navigatorKey.currentState!.pushReplacement(
                  
                  PageTransition(
                      type: PageTransitionType.fade, child: LoginPage()));
    });

    notifyListeners();
  } catch (e) {
    print("error");
  }
  notifyListeners();
}
////////////////////////logout end//////////////////////////

//////////////Sign in with google///////////////////////

  Future googleLogin(BuildContext context)async{

    try {
      // isLoading =true;
      final googleUser = await googlesign.signIn();

      if (googleUser == null) return;

      _user = googleUser;
String? token = await FirebaseMessaging.instance.getToken();
      final googleAuth = await googleUser.authentication;
isLoading =true;
      final credentil = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,

      );
      await FirebaseAuth.instance.signInWithCredential(credentil);
      if(credentil.idToken!=null) {
        isLoading=true;
        navigatorKey.currentState!.pushReplacement(
                  
                  PageTransition(
                      type: PageTransitionType.fade, child: HomePage()));

                      DocumentSnapshot docSnapshot = await 
                      FirebaseFirestore.instance.collection('user').
                      doc(FirebaseAuth.instance.currentUser!.email).get();
bool isDocExists = docSnapshot.exists;
if(isDocExists== true){
  print("User Already Exist");
}
else{
        final collection =
        FirebaseFirestore.instance.collection('user');

       
        await collection.doc(FirebaseAuth.instance.currentUser!.email).set({
          
          'id':user.id,
          'email': user.email,
          'name':user.displayName,
          'token': token,
          'gender': '',
          'updated_at': '',
          'deleted_at': '', 
          'created_at': FieldValue.serverTimestamp(), 
          'date_of_birth': '',
          'image':'', 
          'caretaker_email':'',
          'caretaker_token':'',

        });
      }
    
      }
    }catch(e){

    }
    notifyListeners();
  }
  //////////////////////sign in with google end///////////
  //////////////////////google logout//////////
    Future logout(BuildContext context)async{
    await googlesign.disconnect();
    await FirebaseAuth.instance.signOut();
    navigatorKey.currentState!.pushReplacement(
                  
                  PageTransition(
                      type: PageTransitionType.fade, child: LoginPage()));

                      notifyListeners();
  }
  ///////////Google logout end////////////////
/////////////////////Get Care Taker name//////////////////////////
    void getCaretakerInPatient() async{

FirebaseFirestore.instance.collection("caretaker").
where('patient_email', isEqualTo: _auth.currentUser!.email).get().
then((value){
            value.docs.first.data()['caretaker_email'];
            ct_name = value.docs.first.data()['care_taker_name'].toString();
            ct_email = value.docs.first.data()['caretaker_email'].toString();

            print("token");
            print(ct_email);
});
 notifyListeners();
  }

/////////////////////Get Image///////////////////
getProfileImage(){
 if(_auth.currentUser!.photoURL!=null){
  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: Image.network("${_auth.currentUser!.photoURL}"));
 }
 else {
  return Icon(Icons.account_circle, size: 30,);
 }
}

}