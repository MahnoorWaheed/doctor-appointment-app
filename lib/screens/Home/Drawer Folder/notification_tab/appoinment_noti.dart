
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/screens/AppointmentScreen/appointments.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
  
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:doctor_appointment/utils/utils.dart';

  
import 'package:doctor_appointment/widgets/bottom_nav.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:ymchat_flutter/ymchat_flutter.dart';

class AppoinmentNotifications extends StatefulWidget {
  const AppoinmentNotifications({ Key? key }) : super(key: key);

  @override
  State<AppoinmentNotifications> createState() => _AppoinmentNotificationsState();
}

class _AppoinmentNotificationsState extends State<AppoinmentNotifications> {
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
  resizeToAvoidBottomInset: false,
  appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text("Notifications"),
             titleTextStyle: GoogleFonts.poppins(
              color:Theme.of(context).appBarTheme.backgroundColor,
             fontSize:20,
             fontWeight:FontWeight.w700
             ),    
                
                leading: IconButton(
                    onPressed: () {
                      //  _scaffoldKey.currentState!.openDrawer();
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: HomePage(),
                            type: PageTransitionType.fade,
                          ),
                              (route) => false);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.grey)),
              ),
             
             
      body: Stack(
        children: [

         
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            
               Center(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Container(
                     margin: EdgeInsets.only(top: 8),
                     width: MediaQuery.of(context).size.width*0.9,
                     height: MediaQuery.of(context).size.height*0.75,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(16),
                       color: Colors.white,
                       
                     ),
                     
                     child: Stack(
                       children: [
                         Center(
                           child: Lottie.asset('assets/99861-notification-bell.json',)
                         ),
                       
                         SizedBox(
                          child:StreamBuilder<QuerySnapshot>(
                           stream: FirebaseFirestore.
                         instance.collection("add_appointment").
                         doc(_auth.currentUser!.uid).
                         collection('appointment_reminder').where("status",isEqualTo: 2).snapshots(),
                                     builder: (context,snapshot){
                                       if(!snapshot.hasData){
                                         return const Center(
                        child: CircularProgressIndicator(),
                                         );
                                       }
                                       return
                          ListView.builder(
                           
                           itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                            DocumentSnapshot notification=snapshot.data!.docs[index];
                              return   SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  
                                    Padding(
                                            padding: const EdgeInsets.only(left: 5,right: 5),
                                            child: SizedBox(
                                            height: ScreenHeight(context)*0.12,
                                            width: ScreenWidth(context)*0.9,
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                
                                                Card(
                                                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
                                                  elevation: 10,
                                                  // color: Theme.of(context).appBarTheme.backgroundColor,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:15.0, top: 0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                           
                                                            Container(
                                                              child: Text("${notification['name']}",
                                                              maxLines: 2
                                                               ,
                                                               style: GoogleFonts.poppins(
                                                                color: Theme.of(context).appBarTheme.backgroundColor, 
                                                                fontWeight: FontWeight.bold
                                                              ),),
                                                            ),
                                                            SizedBox(height: ScreenHeight(context)*0.02),
         
                                                            
                                                            Row(
                                                              children: [
                                                                 Container(
                                                              child: Text("Schedule On: ",
                                                              maxLines: 2
                                                               ,
                                                               style: GoogleFonts.poppins(
                                                                color: Theme.of(context).appBarTheme.backgroundColor, 
                                                                fontWeight: FontWeight.normal
                                                              ),),
                                                            ),
                                                                Center(
                                                                  child: Text(notification['start_time'], style: GoogleFonts.poppins(
                                                                  color: Theme.of(context).appBarTheme.backgroundColor,
                                                                )),
                                                                ),
                                                              ],
                                                            ),
                                                            
                                                          ],
                                                        ),
                                                        
                                                      Container(
                                                        height:  ScreenHeight(context)*0.3,
                                                        width:  ScreenHeight(context)*0.15,
                                                        
                                                        decoration:  BoxDecoration(
                                                          color: Theme.of(context).appBarTheme.backgroundColor,
                                                          borderRadius:const BorderRadius.only(
                                                            topRight: Radius.circular(50),
                                                            bottomRight: Radius.circular(50)
                                                          )
                                                        ),
                                                        child: Lottie.asset('assets/88284-doctor-prescription.json',
                                                         height: ScreenHeight(context)*0.3),
                                                      )
                                                        
                                                      ],),
                                                  )),
                                                  
                                                       Positioned(
                                                        top: -15,
                                                        right: -15,
                                                         child: IconButton(onPressed: (){
                                                           FirebaseFirestore.instance.collection('add_appointment').
                                                           doc(_auth.currentUser!.uid).collection('appointment_reminder').
                                                           doc(notification['id']).update({
                                                            'status':1
                                                           });
                                                           }, icon: Icon(Icons.cancel,color: Colors.red,)),
                                                       ),
                                                       Positioned(
                                                        bottom: -30,
                                                        left: 30,
                                                         child: Container(
                                                          height: 50,
                                                          
                                                          width: 250,
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue.shade200,
                                                            borderRadius: BorderRadius.circular(30),
                                                          ),
                                                          child: Center(
                                                            child: Text(notification['reason'], 
                                                            textAlign: TextAlign.center,
                                                            style: GoogleFonts.poppins(
                                                              fontSize:ScreenHeight(context)*0.02,
                                                              color: Colors.white
                                                            ),
                                                            ),
                                                          ),
                                                         ),
                                                       )

                                              ],
                                            )),
                                                           ),
                                    SizedBox(height: ScreenHeight(context)*0.05,),
                                  ],
                                ),
                              );
                              
                              
                             
                              });
                              }),
                     )],
                     )
                   ),
                 ),
               ),
              
          
            ],
          ),
          
            BottomNavbar()
        ],
      ),
      
      );
  }
  


}