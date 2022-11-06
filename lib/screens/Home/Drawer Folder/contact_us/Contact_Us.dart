
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_appointment/utils/global.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/widgets/alert_dialogue.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Contact_Us extends StatefulWidget {
  const Contact_Us({ Key? key }) : super(key: key);

  @override
  State<Contact_Us> createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  int _index = 2;
   TextEditingController emailController= TextEditingController();
    TextEditingController firstNameController= TextEditingController();
     TextEditingController lastNameController= TextEditingController();
TextEditingController bodyController= TextEditingController();
TextEditingController receiverEmailController= TextEditingController();
TextEditingController subjectController= TextEditingController();

 final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  bool isHTML = false;
  

   Future<bool> backclose() async {
    // SystemNavigator.pop();
    navigatorKey.currentState!.push(
       
        PageTransition(
          child: HomePage(backFrom: true,),
          type: PageTransitionType.fade,
        ),
       );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: backclose,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //AppBar
       appBar: AppBar(
           elevation: 0,
            backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: (){
              navigatorKey.currentState!.push(
                  
                    PageTransition(
                        type: PageTransitionType.fade, child: HomePage(backFrom: true,)
                        ), 
                        );
            },
             icon: Icon(Icons.arrow_back, color: Colors.grey)),
             centerTitle: true,
           
            title: Text("Contact Us"),
             titleTextStyle: GoogleFonts.poppins(
              color:Theme.of(context).appBarTheme.backgroundColor,
             fontSize:20,
             fontWeight:FontWeight.w700
             ),
        ),
        body: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
          },
          child: Stack(
            children: [
              Form(
                key: _formKey,
            //      onChanged: (() {
            //   setState(() {
            //     _enableBtn = _formKey.currentState!.validate();
            //   });
            // }),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name", 
                       style: GoogleFonts.poppins(
                        fontSize:20
                       ),),
                     TextFormField(
                controller: firstNameController,
                       decoration: InputDecoration(
                        // label: Text("First Name"),
                         border: OutlineInputBorder(
              borderSide: BorderSide(
               color: Theme.of(context).appBarTheme.backgroundColor!, 
              width: 5.0),
              )
                       ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Cannot be blank';
                          }
                          return null;
                        })
                     ),
            
                     
                       Text("Email",
                       style: GoogleFonts.poppins(
                        fontSize:20
                       ),),
                     TextFormField(
                controller: emailController,
                       decoration: InputDecoration(
                        // label: Text("From"),
                         border: OutlineInputBorder(
              borderSide: BorderSide(
               color: Theme.of(context).appBarTheme.backgroundColor!, 
              width: 5.0),
              )
                       ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Cannot be blank';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        })
                     ),
                     Text("Subject", 
                       style: GoogleFonts.poppins(
                        fontSize:20
                       ),),
                     TextFormField(
                controller: subjectController,
                       decoration: InputDecoration(
                        // label: Text("First Name"),
                         border: OutlineInputBorder(
              borderSide: BorderSide(
               color: Theme.of(context).appBarTheme.backgroundColor!, 
              width: 5.0),
              )
                       ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Cannot be blank';
                          }
                          return null;
                        })
                     ),
                     
                       Text("Message", 
                       style: GoogleFonts.poppins(
                        fontSize:20
                       ),
                       ),
                     TextFormField(
                controller: bodyController,
                maxLines: 10,
                maxLength: 200,
                keyboardType: TextInputType.multiline,
                       decoration: InputDecoration(
                        
                        // label: Text("Message"),
                         border: OutlineInputBorder(
              borderSide: BorderSide(
               color: Theme.of(context).appBarTheme.backgroundColor!, 
              width: 5.0),
              )
                       ),
                       
                        validator: ((value) {
                          if (value!.isEmpty) {
                            setState(() {
                              _enableBtn = true;
                            });
                            return 'Cannot be blank';
                          }
                          return null;
                        }),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical:1.0),
                       child: Center(
                         child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                
                                  primary:Theme.of(context).appBarTheme.backgroundColor!),
                                  onPressed: () async{
            
                              
                  if (_formKey.currentState!.validate()) {
                                
                               final Email send_email = Email(
  body: bodyController.text,
  subject: subjectController.text,
  recipients: ['mahnoorwaheed8395@gmail.com'],
  
  
);

await FlutterEmailSender.send(send_email);
            
                              }
                              else{
                                 
                             print("Failed");
                              }
                                 }, child: Text("Send", 
                                 style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                                 )),
                       ),
                     )
            
                      ],
                    ),
                  ),
                ),
              )
            
            
            
            ],
          ),
        )
      
        ),
    );
  }

}