import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:doctor_appointment/screens/Home/Drawer%20Folder/about/privacy_policy.dart';
import 'package:doctor_appointment/screens/Home/Drawer%20Folder/about/terms_condition.dart';
import 'package:doctor_appointment/utils/global.dart';

import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/widgets/drawer_widget.dart';
import 'package:page_transition/page_transition.dart';
class About extends StatefulWidget {
  const About({ Key? key }) : super(key: key);
  @override
  State<About> createState() => _AboutState();
}
class _AboutState extends State<About> {
int _index = 2;

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
              title: Text("About"),
             titleTextStyle: GoogleFonts.poppins(
              color:Theme.of(context).appBarTheme.backgroundColor,
             fontSize:20,
             fontWeight:FontWeight.w700
             ),  
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Text("About",
                     style: GoogleFonts.poppins(
                       color: Colors.black87,
                       fontSize: 25,
                       fontWeight: FontWeight.w900
                     ),),
                 ),
    SizedBox(height: 5,),
             Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: GestureDetector(
                      onTap: (){
                        navigatorKey.currentState!.push(
                           PageTransition(child: PrivacyPolicy(), type: PageTransitionType.fade,), 
        );
                        },
                       child: Container(
                         width: MediaQuery.of(context).size.width*0.9,
                         height: MediaQuery.of(context).size.height*0.15,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(16),
                           color: Colors.white,
                           boxShadow: [
                             BoxShadow(
                                color: Colors.grey,
                                offset: const Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 2.0,
                                spreadRadius: 0.0,), ]),
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Privacy Policy", 
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).appBarTheme.backgroundColor,),),
                                Container(
                                  width: ScreenWidth(context)*0.7,
                                  child: Text(
                                    "Welcome to Doctor Appointment Reminder. This App is launched by Team of Flutter Developers.",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    )) ],),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_right_alt_rounded, 
                                 color: Theme.of(context).appBarTheme.backgroundColor,
                              size: 25,)],),],), ),),),
                  Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: GestureDetector(
                      onTap: (){
                       navigatorKey.currentState!.push(PageTransition(child: TermCondition(), type: PageTransitionType.fade,), 
       );
                      },
                       child: Container(
                         width: MediaQuery.of(context).size.width*0.9,
                         height: MediaQuery.of(context).size.height*0.15,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(16),
                           color: Colors.white,
                           boxShadow: [
                             BoxShadow(
                                color: Colors.grey,
                                offset: const Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                              ), 
                           ]
                         ),
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Terms & Conditions", 
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).appBarTheme.backgroundColor,),),
                                Container(
                                  width: ScreenWidth(context)*0.7,
                                  child: Text(
                                    "These Terms of Service (“Terms”, “Terms of Service”) govern your use of our website located at ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,))],),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_right_alt_rounded, 
                                 color: Theme.of(context).appBarTheme.backgroundColor,
                                 size: 25,)])]))))])]))),
    );}}