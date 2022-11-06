import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/notifier/firebase_provider.dart';
import 'package:doctor_appointment/screens/auth/Login/login.dart';
import 'package:doctor_appointment/utils/global.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/widgets/action_button.dart';
import 'package:doctor_appointment/widgets/alert_dialogue.dart';
import 'package:doctor_appointment/widgets/field_title.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
enum LoginType {
  Google,
  Twitter,
  Facebook
}
class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController nameController=TextEditingController();
TextEditingController conPassController=TextEditingController();
  bool isLoading= false;
  bool _obscureText = true;
  bool _obscureText1 = true;
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

Future<bool> backclose() async {
    // SystemNavigator.pop();
    navigatorKey.currentState!.push(
              
                  PageTransition(
                      type: PageTransitionType.fade, child: LoginPage()));
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backclose,
      child: GestureDetector(
      onTap: (){
              FocusScopeNode currentFocus = FocusScope.of(context);
      
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
            },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: isLoading ==true
              ? Center(
                  child: Container(
                    height: ScreenHeight(context)*0.1,
                    width: ScreenWidth(context)*0.1,
                    child: CircularProgressIndicator(),
                  ),
                )
              : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    
                        children: [
                  
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                        padding: const EdgeInsets.only(left:22.0, top: 10),
                        child: IconButton(onPressed: (){
                           navigatorKey.currentState!.push( PageTransition(child: LoginPage(), type: PageTransitionType.fade,), 
      );
                        }, icon: Icon(Icons.arrow_back, color: Colors.grey.shade600, size: 30,)),
                      ),
                        
                         Center(
                           child: FieldTitle(
                             title: "Signup",
                             textColor: Colors.black,
                             fontWeight: FontWeight.normal,
                             fontSize: 35,
                           ),
                         ),
                Padding(
                        // padding: const EdgeInsets.symmetric(horizontal:20.0),
                        padding:  EdgeInsets.only(left:25.0, top: 15, right: 25, bottom: 10),
                        child: TextFormField(
                          
                              controller: nameController,
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
                           errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                             prefixIcon: Padding(
                                         padding: const EdgeInsets.only(right: 20 ),
                                           child: Icon(Icons.person,color:Colors.grey.shade600 ,size: 22,),
                                         ),
                             label: Text("Full Name", style: GoogleFonts.poppins(fontSize: 13),),
                                         
                                         
                                         isDense: true,                      // Added this

                                         constraints: BoxConstraints(maxWidth: ScreenWidth(context)*0.85)
                        
                            ),
                          validator: (value){
                             if (value!.isEmpty) {
                           return 'Name is empty';
                         }
                         return null;
                          },
                            ),
                      ),
                        Padding(
                       padding:  EdgeInsets.only(left:25.0, top: 15, right: 25, bottom: 10),
                        child: TextFormField(
                      validator: (value) => validateEmail(value),
                              controller: emailController,
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
                           errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Theme.of(context).appBarTheme.backgroundColor!,
                          )),
                             prefixIcon: Padding(
                                         padding: const EdgeInsets.only(right: 20 ),
                                           child: Icon(Icons.email,color:Colors.grey.shade600 ,size: 22,),
                                         ),
                             label: Text("Email ID", style: GoogleFonts.poppins(fontSize: 13),),
                                         
                                         
                                         isDense: true,                      // Added this
                                         
                                         constraints: BoxConstraints(maxWidth: ScreenWidth(context)*0.85)
                      
                            ),
                          
                            ),
                      ),
                        Padding(
                       padding:  EdgeInsets.only(left:25.0, top: 15, right: 25, bottom: 10),
                        child: TextFormField(
                       validator: (value){
                             if (value!.isEmpty) {
                           return 'Password is empty';
                         }
                         return null;
                          },
                          // validator: (val){
                                
                          //         if (val!.length<8) {
                          //         return "Please enter more than 8 characters";
                          //       }
                               
                          //     },
                         obscureText: _obscureText,
                                controller: passController,
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
                                prefixIcon: Padding(
                                         padding: const EdgeInsets.only(right: 20 ),
                                           child: Icon(Icons.lock,color:Colors.grey.shade600 ,size: 22,),
                                         ),
                                label: Text("Password", style: GoogleFonts.poppins(fontSize: 13),),
                                         
                                         
                                         isDense: true,                      // Added this
                                         
                                         constraints: BoxConstraints(maxWidth: ScreenWidth(context)*0.85),
                                suffixIcon: new GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child:
                  new Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                                ),
                            ),
                            ),
                      ),
                      Padding(
                       padding:  EdgeInsets.only(left:25.0, top: 15, right: 25, bottom: 10),
                        child: TextFormField(
                      validator: (value){
                             if (value!.isEmpty) {
                           return 'Confirm password is empty';
                         }
                         else if(passController.text!=value){
                          return 'Password did not matched';
                         }
                         return null;
                          },
                          obscureText: _obscureText1,
                                controller: conPassController,
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
                                 prefixIcon: Padding(
                                         padding: const EdgeInsets.only(right: 20 ),
                                           child: Icon(Icons.lock,color:Colors.grey.shade600 ,size: 22,),
                                         ),
                                label: Text("Confirm Password", style: GoogleFonts.poppins(fontSize: 13),),
                                         
                                         
                                         isDense: true,                      // Added this
                                         
                                         constraints: BoxConstraints(maxWidth: ScreenWidth(context)*0.85),
                      
                                suffixIcon: new GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText1 = !_obscureText1;
                    });
                  },
                  child:
                  new Icon(_obscureText1 ? Icons.visibility_off : Icons.visibility),
                                ),
                            ),
                            ),
                      ),                     
                        const SizedBox(
                          height: 18,
                        ),
                         //////////////////
                         ActionButton(
                          actionChild: Icon(Icons.login),
                          title: 'Sign up',
                          ontap: ()async{
                            
if(_formKey.currentState!.validate()){
  if(
    passController.text==conPassController.text
  ){
    Provider.of<FirebaseProvider>(context, listen: false).
                                createAccount(nameController.text, emailController.text,
                                passController.text, conPassController.text, context).then((user) {
if (user != null) {
                        
                      //   navigatorKey.currentState!.push(
                     
                      // PageTransition(
                      //     type: PageTransitionType.fade, child: LoginPage()));
                        print("Account Created Sucessfull");
                        showDialog(context: context, builder: (context){
                          return AlertDialogWidegt(
                            title: 'Account has been created',
                            desc: 'For more services verify your account',
                            onTap: () =>navigatorKey.currentState!.push(
                  
                    PageTransition(
                        type: PageTransitionType.fade, child: LoginPage()))
                          );
                          
                      
                        });
                              } else{
  print("user already registered");
  // showDialog(context: context, builder: (context){
  //                         return AlertDialogWidegt(
  //                           title: 'Registration Failed',
  //                           desc: 'Email is already used',
  //                           onTap: () => Navigator.pop(context),
  //                         );
                          
                      
  //                       });
 }
                                });
  }

 }

                          
                          },
                         
                         ),
                        
                      ],
                    ),
                  ),
                        ],
                      ),
                ),
              ),
        ),
      ),
    );
  }

}

