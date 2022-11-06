import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:doctor_appointment/notifier/Appointment_Provider/appointment_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';

import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/widgets/action_button.dart';
import 'package:doctor_appointment/widgets/bottom_nav.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'AppointmentCancel/appointment_cancel.dart';
import 'AppointmentCompleted/appointment_completed.dart';
import 'UpComingAppointment/upcoming.dart';

class AppointmentsUpComing extends StatefulWidget {
  const AppointmentsUpComing({Key? key}) : super(key: key);

  @override
  State<AppointmentsUpComing> createState() => _AppointmentsUpComingState();
}

class _AppointmentsUpComingState extends State<AppointmentsUpComing> {
  int _index = 0;
  int labelindex = 0;

  Widget swapbutton = UpComing();


  @override
  void initState() {
    // UpComing();
    super.initState();
  }

  Future<bool> backclose() async {
    // SystemNavigator.pop();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          child: HomePage(),
          type: PageTransitionType.fade,
        ),
        (route) => false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Color kActiveColor = Theme.of(context).appBarTheme.backgroundColor!;

    return WillPopScope(
      onWillPop: backclose,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text("Schedule Appointment"),
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
          body: 
          Stack(children: [
           
            Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
    
appointmentContainer(context,'assets/lf30_editor_3jgljaly.json','${Provider.of<AppointmentProvider>(context, listen: false).appointmentlist.length}', 'Upcoming Appointments',(){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>UpComing()));
} ),
appointmentContainer(context,'assets/lf30_editor_3jgljaly.json','${Provider.of<AppointmentProvider>(context, listen: false).completelist.length}', 'Complete Appointments',(){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Completed()));
} ),
appointmentContainer(context,'assets/lf30_editor_3jgljaly.json','${Provider.of<AppointmentProvider>(context, listen: false).cancellist.length}', 'Cancel Appointments' ,(){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Cancelled()));
}),

SizedBox(height: ScreenHeight(context)*0.08,)
              ],
            ),
            BottomNavbar()
          ]),
        
        ),
      ),
    );
  }

  Center appointmentContainer(BuildContext context, String? lottie, 
  String? length, String? title, VoidCallback? ontap,) {
    return Center(
child:   GestureDetector(
  onTap: ontap,
  child:   Container(
  
        height: ScreenHeight(context)*0.2,
  
        width: ScreenWidth(context)*0.9,
  
        decoration: BoxDecoration(
  
        gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
             
              colors: [
                  Colors.red,
                Theme.of(context).appBarTheme.backgroundColor!,
              
              ],
            ),
  
        borderRadius: BorderRadius.circular(20)
  
  
  
        ),
  
      child: Column(
  
        mainAxisAlignment: MainAxisAlignment.spaceAround,
  
        children: [
  
  
  
  Row(
  
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  
    children: [
  
          Container(
  
      height: ScreenHeight(context)*0.055,
  
     width: ScreenWidth(context)*0.15,
  
     decoration: BoxDecoration(
  
      color: Colors.white,
  
      borderRadius: BorderRadius.circular(10),
  
      ),
  
      child: Lottie.asset('$lottie'),
  
      ),
  
      Text("$title", style: GoogleFonts.poppins(
  
        color: Colors.white,
  
        fontWeight: FontWeight.bold
  
      ),),
  
    ],
  
  ),
  
  Row(
  
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  
    children: [
  
          Text("Total", style: GoogleFonts.poppins(
  
        color: Colors.white,
  
        fontWeight: FontWeight.bold
  
      ),),
  
      Text("$length", style: GoogleFonts.poppins(
  
        color: Colors.white,
  
        fontWeight: FontWeight.bold
  
      ),),
  
    ],
  
  ),
  
       
  
           
  
       
  
        ],
  
      ),
  
      ),
),
);
  }
}
