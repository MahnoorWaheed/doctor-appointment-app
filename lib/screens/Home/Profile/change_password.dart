import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doctor_appointment/screens/auth/Login/login.dart';
import 'package:doctor_appointment/utils/global.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/widgets/alert_dialogue.dart';
import 'package:doctor_appointment/widgets/field_title.dart';
import 'package:doctor_appointment/widgets/fields.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';



class ChangePassword extends StatefulWidget {
  const ChangePassword({ Key? key }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController searchTextEditingController =
      new TextEditingController();
  bool isLoading = true;
  QuerySnapshot? namee;
  // String? userName;
  // String? userPass;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;
 TextEditingController newPasswordcontroller=TextEditingController();
 TextEditingController currentPassController=TextEditingController();
  TextEditingController reEnterNewPassController=TextEditingController();
   final _formKey = GlobalKey<FormState>();
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _obscureText2=!_obscureText2;
      _obscureText3=!_obscureText3;
    });
  }


  String? email = " ";
  String? password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // ignore: deprecated_member_use
  final _firestore = FirebaseFirestore.instance;
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, PageTransition(child: HomePage(), type: PageTransitionType.fade,), 
        (route) => false);
                },
                icon: Icon(Icons.arrow_back, color: Colors.grey)),
          ),),
        body: GestureDetector(
          onTap: (){
              FocusScopeNode currentFocus = FocusScope.of(context);
    
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
            },
          child: SingleChildScrollView(
            child: Column(
             
              children: [
                
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Image.asset("name"),
                      Container(
                        height: MediaQuery.of(context).size.height*0.3,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Lottie.asset("assets/114347-password-animation.json", 
                        
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: FieldTitle(
                          title: "Change",
                          textColor: Theme.of(context).appBarTheme.backgroundColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: FieldTitle(
                          title: "Password?",
                          textColor:Theme.of(context).appBarTheme.backgroundColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 35,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        width: ScreenWidth(context)*0.9,
                        child: Text("You can change your password here",
                        style: GoogleFonts.poppins(),
                        )),
                      
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: TextFormField(
                                validator: ((value) {
                         if (value!.isEmpty) {
                           return 'Cannot be blank';
                         }
                         return null;
                         }),
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                           errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                                  label: Text("Current Password"), 
                                  suffixIcon: GestureDetector(
                                  onTap: () {
                                          setState(() {
                                          _obscureText = !_obscureText;
                                          });
                                          },
                              child:
                              new Icon(_obscureText ? Icons.visibility_off :
                              Icons.visibility),
                                          ),
                                ),
                                // label: "Current Password",
                                // icon: const Icon(Icons.password),
                              controller: currentPassController,
                              
                              ),
                            ),
                            SingleChildScrollView(
                        child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 10),
                          child: TextFormField(
                          validator: ((value) {
                           if (value!.isEmpty) {
                             return 'Cannot be empty';
                           }
                           return null;
                           }),
                          obscureText: _obscureText2,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                           errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                            label: Text("New Password"),
                            suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                            child:
                            new Icon(_obscureText2 ? Icons.visibility_off :
                            Icons.visibility),
                          ), 
                          ),
                          // label: "New Password",
                          // icon: const Icon(Icons.lock),
                          controller: newPasswordcontroller,
                          
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal:20.0),
                          child: TextFormField(
                          validator: ((value) {
                           if (value!.isEmpty) {
                             return 'Cannot be blank';
                           }
                           return null;
                           }),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                           errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                              label:Text("Re-enter Password"),
                              suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText3 = !_obscureText3;
                              });
                            },
                            child:
                            new Icon(_obscureText3 ? Icons.visibility_off :
                            Icons.visibility),
                          ),
                            ),
                          obscureText: _obscureText3,
                          
                          // icon: const Icon(Icons.lock),
                          controller: reEnterNewPassController,
                          
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GestureDetector(
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                           if(newPasswordcontroller.text==reEnterNewPassController.text){
                            
                            _changePassword(currentPassController.text,
                                newPasswordcontroller.text, reEnterNewPassController.text);
                                showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialogWidegt(
                                    title: "Change Password",
                                    desc: "Your password has been changed",
                                    onTap: (){
                                       navigatorKey.currentState!.pushAndRemoveUntil( 
                                        PageTransition(child: LoginPage(), type: PageTransitionType.fade,), (route) => false);
                       
                                    },
                                  );
                                });

                          }
                          else{
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.white,
                                    insetPadding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0)), //this right here
                                    child: SizedBox(
                                      height: ScreenHeight(context) *
                                          0.27,
                                      width:
                                          ScreenWidth(context) * 0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // LargeText(
                                                //   text: 'Pick Image',
                                                //   color: Colors.white,
                                                // ),
                                                Text('Password Matching failed',
                                                style: GoogleFonts.poppins(
                                                  color: Theme.of(context).appBarTheme.backgroundColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ScreenHeight(context)*0.028,
                                                )
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 30, right: 30),
                                            child: Divider(
                                              height: 2,
                                              color: Theme.of(context).appBarTheme.backgroundColor,
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 0, top: 40),
                                              //width: ScreenUtils.screenwidth(context) * 0.7,
                                              child: Text(
                                                 "Re-enter correct password",
                                                 style: GoogleFonts.poppins(
                                                  color: Theme.of(context).appBarTheme.backgroundColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ScreenHeight(context)*0.02
                                                 ),
                                              )),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 40.0, right: 0, left: 0),
                                              child: Container(
                                                height: ScreenHeight(context) *
                                                    0.04,
                                                width: ScreenWidth(context) *
                                                    0.27,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15.0),
                                                  color:Theme.of(context).appBarTheme.backgroundColor,
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  'OK',
                                                  style: GoogleFonts.poppins(
                                                        color: Colors.white
                                                            ,
                                                        fontSize: ScreenHeight(context)
                                                               *
                                                            0.02,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                          }
                          
                         
                          
                          
                        },
                        
                        child: Container(
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.width * 0.8,
                                              decoration:  BoxDecoration(
                                                  color: Theme.of(context).appBarTheme.backgroundColor,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.black26,
                                                        offset: Offset(2, 2),
                                                        blurRadius: 5)
                                                  ],
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  )),
                                              child: Center(
                                                child: Text(
                                                  'Submit',
                                                  style: GoogleFonts.poppins(
                                                   // color: Color(0xff57b547),
                                                   color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              ),
                                            ),
                        ),
                    
                      ),
                      
                          
                      
                       
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _changePassword(String currentPassword, String newPassword, String reNewPass) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email.toString(), password: currentPassword );

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
        print("Password is updated");
        FirebaseFirestore.instance.collection("user").doc(user.uid).update({
         'password': newPassword
        });
      //  Navigator.pushAndRemoveUntil(context, PageTransition(child: LoginPage(), type: PageTransitionType.fade,), 
      // (route) => false);
      }).catchError((error) {
        //Error, show something
      });
    }).catchError((err) {

    });}

}