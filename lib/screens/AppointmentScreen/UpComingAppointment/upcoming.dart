import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:doctor_appointment/screens/AppointmentScreen/appointments.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:doctor_appointment/widgets/action_button.dart';
import 'package:doctor_appointment/widgets/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/notifier/Appointment_Provider/appointment_provider.dart';
import 'package:doctor_appointment/screens/backgroud/rimender.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../models/Appointments_Model/appointments_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/appointmentslimited/limited_dialog.dart';
import '../Appoinments_details.dart';

class UpComing extends StatefulWidget {

  UpComing({ Key? key }) : super(key: key);

  @override
  State<UpComing> createState() => _UpComingState();
}

class _UpComingState extends State<UpComing> {

  User? user;

  final limited= LimitedDialog();

  DateTime selectedDate = DateTime.now();

  final NotificationService _notificationService = NotificationService();
  DateTime fullDate = DateTime.now();
  String newTime = "Start Time";
  String newTime2 = "End Time";
  String popvalue = '';
  String medicineName = '';
  String endday = "";
  String start_date = "";
  String token2 = '';
  String dr_name = "";
  String id = '';

Future<bool> backclose() async {
    // SystemNavigator.pop();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          child: AppointmentsUpComing(),
          type: PageTransitionType.fade,
        ),
        (route) => false);
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: backclose,
        child: Consumer<AppointmentProvider>(
            builder: (_, appointments, __) => Stack(
clipBehavior: Clip.none,
              children: [
                 Container(
                      height: ScreenHeight(context)*0.15,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)
                        )),
                        child: Row(
                          children: [
                            IconButton(
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
                    icon: Icon(Icons.arrow_back, color: Colors.white)),
                    SizedBox(width: ScreenWidth(context)*0.17, height:ScreenHeight(context)*0.1 ,),
                    Text("Upcoming Appointments", style: GoogleFonts.poppins(
  
        color: Colors.white,
  
        fontWeight: FontWeight.bold
  
      ),),
                          ],
                        ),
                      ),
               
                SingleChildScrollView(
                
                child: Column(
                  children: [
                    SizedBox(height: ScreenHeight(context)*0.1,),
                    Center(
                        child: Container(
                          height: ScreenHeight(context)*0.9,
                          width: ScreenWidth(context)*0.9,
                          // margin: EdgeInsets.symmetric(horizontal: ScreenWidth(context)*0.09),
                          child:appointments.isAppointmentloaded?
                             ListView.builder(
                              physics: BouncingScrollPhysics(),
                                    itemCount: appointments.appointmentlist.length,
                                    itemBuilder: ((context, index){
                                      return Padding(
                                        padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01, left: MediaQuery.of(context).size.height*0.006, right:  MediaQuery.of(context).size.height*0.006,),
                                        child: Stack(
                                         
                                          children: [
                                            
                                            Center(
                                              child: Container(
                                                height: ScreenHeight(context)*0.13,
                                                width: ScreenWidth(context)*0.8,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Theme.of(context).appBarTheme.backgroundColor,
                                                ),
                                                  //width: double.infinity,
                                                //  color: Colors.blue,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap:(){
                                                        limited.showNameDatetime(context:context,
                                                            name: appointments.appointmentlist[index].name,
                                                            reason: appointments.appointmentlist[index].reason,
                                                            date: appointments.appointmentlist[index].start_date,
                                                            time: appointments.appointmentlist[index].start_time,
                     
                                                        );
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                     
                                                            children: [
                                                              Text(appointments.appointmentlist[index].name, style: GoogleFonts.poppins(
                                                                fontSize: MediaQuery.of(context).size.height*0.028,
                                                                color: Colors.white,
                     
                                                              ),),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left:8.0,bottom: 2),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Image.asset('assets/date-solid.png',),
                                                                    SizedBox(width: ScreenWidth(context)*0.01,),
                                                                    Text(appointments.appointmentlist[index].start_date,
                                                                      style: GoogleFonts.poppins(
                                                                        fontSize: MediaQuery.of(context).size.height*0.015,
                                                                        color: Colors.white,
                     
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: ScreenWidth(context)*0.04,),
                                                                    Image.asset('assets/time.png'),
                                                                    SizedBox(width: 5,),
                                                                    Text(appointments.appointmentlist[index].start_time,
                                                                      style: GoogleFonts.poppins(
                                                                        fontSize: MediaQuery.of(context).size.height*0.015,
                                                                        color: Colors.white,
                     
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: ScreenWidth(context)*0.04,),
                                                                    ElevatedButton(
                                                                   style: ElevatedButton.styleFrom(
                                                                     minimumSize: const Size(80, 25),
                                                                     maximumSize: const Size(80, 25),
                                                                     primary: Colors.white,
                                                                     shape: RoundedRectangleBorder(
                       borderRadius: new BorderRadius.circular(30.0),
                       ),
                     
                                                                     textStyle: GoogleFonts.poppins(
                                                                       fontSize: ScreenHeight(context)*0.02,
                                                                       fontWeight: FontWeight.bold,
                                                                     ),
                                                                   ),
                     
                     
                                                                   onPressed: ()  {
                                                                     appointments.complete_status(randomid: appointments.appointmentlist[index].id,index: index);
                     
                                                                     print("COMPLETED");
                     
                                                                   }, child: Text("Complete",
                                                                 style: GoogleFonts.poppins(
                                                                     fontSize: MediaQuery.of(context).size.height*0.012,
                                                                     color: Theme.of(context).appBarTheme.backgroundColor
                     
                                                                 ),)),
                                                             
                                                         
                                                                  ],
                                                                ),
                                                              ),
                                                                
                                                            ],
                                                          ),
                                                         
                                                           
                                                        ],
                                                      ),
                                                    ),
                                                   
                                                  ],
                                                ),
                     
                                              ),
                                            ),
                                          
                                          
                                          Positioned(
                                                                top: -0,
                                                                left:-0,
                                                                 child: Container(
                                                                  height: ScreenHeight(context)*0.05,
                                                                  
                                                                  width: ScreenHeight(context)*0.06,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.blue.shade200,
                                                                    borderRadius: BorderRadius.circular(30),
                                                                  ),
                                                                  child: IconButton(
                                                                   padding:EdgeInsets.zero,
                                                                   onPressed: ()async{
                                                                    print("hello rechedule");
                                                                    dr_name = appointments.appointmentlist[index].name;
                                                                    id = appointments.appointmentlist[index].id;
                                                                    await appointments.selectDate(context, appointments.appointmentlist[index].id,dr_name,token2);
                     
                                                                  },
                                                                      icon: Lottie.asset('assets/72685-man-on-schedule.json',)),
                     
                     
                                                                 ),
                                                               )
                                           ,
                                           Positioned(
                                                                top: -10,
                                                                right:-0,
                                                                 child: IconButton(onPressed: () async {
                     
                                                                  await _notificationService.cancelNotifications();
                                                                 await appointments.cancel_status(randomid: appointments.appointmentlist[index].id,index: index);
                     
                     
                                                                 },
                                                                    icon: Lottie.asset('assets/38993-ocl-canceled.json')),
                                                               ),
                     
                                                               
                                          
                                          ],
                                        )
                                      );
                                    }),
                                  )
                            : null,
                     
                        )),
                         // Padding(
                         //   padding:  EdgeInsets.only(top:ScreenHeight(context)*0.05),
                         //   child: ActionButton(
                       
                         //     fontSize: ScreenHeight(context)*0.02,
                       
                        
                       
                         //     title: "Schedule Appointment",
                       
                         //     ontap: (){ Navigator.push(context, PageTransition(child: Appointments(), type: PageTransitionType.fade));},
                       
                         //   ),
                         // ),
                    ],
                         
                         
                               ),
          ),
              
               BottomNavbar()
              ],
            )),
      ),
    );
  }
}