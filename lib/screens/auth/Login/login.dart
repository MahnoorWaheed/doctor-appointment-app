import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/notifier/firebase_provider.dart';
import 'package:doctor_appointment/screens/auth/forget_password.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:doctor_appointment/screens/auth/Login/signup.dart';
import 'package:doctor_appointment/screens/auth/forget_password.dart';
import 'package:doctor_appointment/utils/global.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/widgets/action_button.dart';
import 'package:doctor_appointment/widgets/alert_dialogue.dart';
import 'package:doctor_appointment/widgets/field_title.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  bool isLoading= false;
  bool _obscureText = true;
  late SharedPreferences logindata;
  late bool newuser;
  var loading= false;
   final _formKey = GlobalKey<FormState>();


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
  void initState()  {
    // TODO: implement initState
    super.initState();
    if(FirebaseAuth.instance.currentUser !=null && FirebaseAuth.instance.currentUser!.emailVerified != true){
       VerifyEmailDialog();

    }
      
      
  }

VerifyEmailDialog() async {
  showDialog(context: context, builder: (context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
                          actions: [
                            Column(
    children: [

      Padding(
        padding: const EdgeInsets.only(top:30.0),
        child: Text("A verification email has sended to your email, if you haven't receive email check your spam folder",textAlign: TextAlign.center, style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),

      SizedBox(height: 40,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

ElevatedButton(
        child: Text('Resend Email',style: TextStyle(fontSize: 12),),
        style:ElevatedButton.styleFrom(
                                       primary: Theme.of(context).appBarTheme.backgroundColor!, // background
                                       onPrimary: Colors.white, 
                                      minimumSize: const Size(100, 40),
                                      maximumSize: const Size(100, 40),// foreground
                                     shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                     )
                                     ),
    
        // onPressed: CanResendEmail?sendVerification:null,
        onPressed: (){
          Future sendVerification()async{
try {
  final user = FirebaseAuth.instance.currentUser!;
  await user.sendEmailVerification();
 

}on FirebaseAuthException catch(e){
  showDialog(context: context, builder: (context){
                          return AlertDialogWidegt(
                            title: "Login Failed",
                            desc: "Email not registered",
                            onTap: (){
                               navigatorKey.currentState!.pop(context);
                            },
                          );
                        });
}
}
        },
      ),
      ElevatedButton(
        child: Text('Ok',style: TextStyle(fontSize: 12),),
        style: ElevatedButton.styleFrom(
                                       primary: Theme.of(context).appBarTheme.backgroundColor!, // background
                                       onPrimary: Colors.white, 
                                      minimumSize: const Size(100, 40),
                                      maximumSize: const Size(100, 40),// foreground
                                     shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                     )
                                     ),
      
        onPressed: () async{
          await FirebaseAuth.instance.signOut();
          navigatorKey.currentState!.pop();

        },
      )
      ],),
      

    ],
  ),
                          ],
                         
                        );
                      });
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
      child:
       Scaffold(
        body: isLoading == true
            ? Center(
                child: Container(
                  height: ScreenHeight(context)*0.1,
                  width: ScreenWidth(context)*0.1,
                  child: CircularProgressIndicator(),
                ),
              )
            :  SafeArea(
          child: SingleChildScrollView(
            child: Column(
            
              children: [
                   
                
               
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                    SizedBox(height: ScreenHeight(context)*0.15,),    
                      Center(
                        child: FieldTitle(
                          title: "Login",
                          textColor: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 35,
                        ),
                      ),
                         Padding(
                                 padding:  EdgeInsets.only(left:25.0, top: 15, right: 25, bottom: 10),
                                 child: TextFormField(
                                  
                                  keyboardType: TextInputType.emailAddress,
                                   controller: emailController,
                                //  selectionWidthStyle:ui.BoxWidthStyle.tight,
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

                                 
                                   focusColor: Theme.of(context).appBarTheme.backgroundColor!,
                                   prefixIcon: Padding(
                                   padding: const EdgeInsets.only(right: 15 ),
                                     child: Icon(Icons.person,color:Colors.grey.shade600 ,size: 22,),
                                   ),
                                   label: Text("Email ID", style: GoogleFonts.poppins(fontSize: 13, 
                                  //  color:  Theme.of(context).appBarTheme.backgroundColor!
                                   ),),
                                 
                  
                  
                                   isDense: true,                      // Added this
                  
                                   constraints: BoxConstraints(maxWidth: ScreenWidth(context)*0.85)
                                 ),
                                 validator: (value) => validateEmail(value),
                                    
                                 ),
                                   ),
                                         Padding(
                    padding:  EdgeInsets.only(left:25.0, top: 15, right: 25, bottom: 10),
                     child: TextFormField(
                         obscureText: _obscureText,
                                     controller: passController,
                         validator: ((value) {
                           if (value!.isEmpty) {
                             return 'Cannot be empty';
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
                                     focusColor: Theme.of(context).appBarTheme.backgroundColor!,
                                     prefixIcon: Padding(
                                       padding: const EdgeInsets.only(top:14.0,right: 15, left: 8 ),
                                       child: FaIcon(FontAwesomeIcons.lock,color:Colors.grey.shade600,size: 20,),
                                     ),
                                     label: Text("Password", style: GoogleFonts.poppins(fontSize: 13, 
                                    //  color: Theme.of(context).appBarTheme.backgroundColor!,
                                     ),),
                                      isDense: true,                      // Added this
                  
                                   constraints: BoxConstraints(maxWidth: ScreenWidth(context)*0.85),
                               suffixIcon: new GestureDetector(
                                     onTap: () {
                                     setState(() {
                                       _obscureText = !_obscureText;
                                     });
                                     },
                                     child:
                                     new Icon(_obscureText ? Icons.visibility_off :
                                     Icons.visibility, color: Theme.of(context).appBarTheme.backgroundColor!,),
                                   ),
                                   ),
                                   // validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                                   //       onSaved: (val) => _password= val,
                  
                                   ),
                                         ),
                        const SizedBox(
                          height: 8,
                        ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                          
                               InkWell(
                                 child: Text("Forgot Password?", 
                                         style: GoogleFonts.poppins(),
                                         textAlign: TextAlign.right,
                                         
                                         ),
                                         onTap: (){
                                         navigatorKey.currentState!.pushReplacement(
                        
                      PageTransition(
                          type: PageTransitionType.fade, child: ForgetPassword()));
                                         },
                               ),
                             ],
                           ),
                         ),
                          const SizedBox(
                          height: 8,
                        ),
                         ActionButton(
                        

                          title: "Login",
                          ontap: () async{
                             if(_formKey.currentState!.validate()){
                              if(emailController.text.trim().isNotEmpty && 
                                passController.text.isNotEmpty){
                                  Provider.of<FirebaseProvider>(context, listen: false).
                                  logIn(emailController.text, 
                                  passController.text, context).then((user) async {
                                        
                                        
                                    if (user != null) {
                         
                           if(FirebaseAuth.instance.currentUser!.emailVerified){
             navigatorKey.currentState!.pushReplacement(
                                         
                                            PageTransition(
                            type: PageTransitionType.fade, child: HomePage()));
                          print("Account Login Sucessfull");
                                }
                                else{
                                  await VerifyEmailDialog();
                                }
                                    }});}}
              
              
              
                  
                          },
                         ),
                          
                        const SizedBox(height:15),
                                            Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Not a member?',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              InkWell(
                                                child: Text(
                                                  ' Register now',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      // color: Color(0xffe6c307),
                                                      color: Theme.of(context).appBarTheme.backgroundColor!,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                onTap: () {
                                                 navigatorKey.currentState!.push(
                      
                      PageTransition(
                          type: PageTransitionType.fade, child: SignUp()));
                          
                                                },
                                              ),
                                            ],
                                          ),
                                                   Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Center(child: Text("OR",
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                        )
                        )),
                      ),
                      ActionButton(
                        actionChild:Image.asset('assets/google.png',
                                  height: ScreenHeight(context)*0.055,
                                  // color: Colors.green,
                                  ) ,
                        title: "SignIn with Google",
                        ontap: ()async{
                                    Provider.of<FirebaseProvider>(context, listen: false).googleLogin(context);
                                   
                                  },
                      ),
                      
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

