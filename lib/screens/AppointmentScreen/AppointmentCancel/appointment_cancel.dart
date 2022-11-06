
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:doctor_appointment/screens/AppointmentScreen/appointments.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:doctor_appointment/widgets/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/screens/backgroud/rimender.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../notifier/Appointment_Provider/appointment_provider.dart';
import '../../../../utils/utils.dart';

class Cancelled extends StatefulWidget {

  Cancelled({ Key? key }) : super(key: key);

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {

  User? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  DateTime selectedDate = DateTime.now();

  final NotificationService _notificationService = NotificationService();
  DateTime fullDate = DateTime.now();
  String newTime = "Start Time";
  String newTime2 = "End Time";
  String popvalue = '';
  String medicineName = '';
  String endday = "";
  String startday = "";
  String token2 = '';
  String dr_name = '';
  String start_date = '';
  String id = '';

  Future<DateTime> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: selectedDate,
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (time != null) {
        setState(() {
          fullDate = DateTimeField.combine(date, time);
          start_date = ("${date.day}/${date.month}/${date.year}");
          newTime = time.format(context).toString();
        });
        //TODO
        //schedule a notification
        if(fullDate!= null){
          await _notificationService.scheduleNotifications(
            id: 1,
            title: medicineName,
            body: "It's time to eat medicine",
            time: fullDate,
            token: token2,
            type: 'appointment',
            doc_id: id
          );
          //dr_name
          Provider.of<AppointmentProvider>(context,listen: false).RescheduleAppointment(
              name: dr_name,
              start_date: start_date,
              newTime: newTime,
              id: id);
          
        }

      }
      return DateTimeField.combine(date, time);
    } else {return selectedDate;}}

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
            builder: (_, appointments, __) =>
                Stack(
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
                    Text("Cancel Appointments", style: GoogleFonts.poppins(
  
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
                              child:appointments.isAppointmentloaded?
                                 ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                      itemCount: appointments.cancellist.length,
                                      itemBuilder: ((context, index){
                              
                                        return Container(
                                          height: ScreenHeight(context)*0.13,
                                                      width: ScreenWidth(context)*0.9,
                                          child: Card(
                                            
                                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                                                              elevation: 10,
                                            //  width: ScreenWidth(context)*0.1,
                                            //  color: Colors.blue,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                              
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(appointments.cancellist[index].name, style: GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(context).size.height*0.022,
                                                        color: Theme.of(context).appBarTheme.backgroundColor,
                              
                                                      ),),
                                                      Row(
                                                        children: [
                                                          Image.asset('assets/date-solid.png'),
                                                          SizedBox(width: ScreenWidth(context)*0.02,),
                                                          Text(appointments.cancellist[index].start_date,
                                                            style: GoogleFonts.poppins(
                                                              fontSize: MediaQuery.of(context).size.height*0.015,
                                                              color: Theme.of(context).appBarTheme.backgroundColor,
                              
                                                            ),
                                                          ),
                                                          SizedBox(width: ScreenWidth(context)*0.042,),
                                                          Image.asset('assets/time.png'),
                                                          SizedBox(width: ScreenWidth(context)*0.025,),
                                                          Text(appointments.cancellist[index].start_time,
                                                            style: GoogleFonts.poppins(
                                                              fontSize: MediaQuery.of(context).size.height*0.015,
                                                              color: Theme.of(context).appBarTheme.backgroundColor,
                              
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
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
                                                                    child:  Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal:5.0, ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: ()async{
                              
                                                         // setState(() {
                                                            dr_name =appointments.cancellist[index].name;
                                                            id = appointments.cancellist[index].id;
                                                         // });
                                                          _selectDate(context);
                              
                                                         await appointments.cancellist.removeAt(index);
                              
                              
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.23,
                                                          height: MediaQuery.of(context).size.height*0.033,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(15),
                                                            color: Colors.white,
                              
                                                          ),
                                                          child: Center(child:
                              
                                                          Text("Reschedule",
                                                            style: GoogleFonts.poppins(
                                                                color: Theme.of(context).appBarTheme.backgroundColor,
                                                                fontSize: MediaQuery.of(context).size.height*0.015,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                              
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: ScreenHeight(context)*0.015,),
                                                      GestureDetector(
                                                        onTap: ()async{
                                                          print('delete');
                                                         await  appointments.deleteappointment(id: appointments.cancellist[index].id);
                                                         await appointments.cancellist.removeAt(index);
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.23,
                                                          height: MediaQuery.of(context).size.height*0.032,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(15),
                                                            color: Colors.white,
                              
                                                          ),
                                                          child: Center(child:
                                                          Text("Delete",
                                                            style: GoogleFonts.poppins(
                                                                color: Theme.of(context).appBarTheme.backgroundColor,
                                                                fontSize: MediaQuery.of(context).size.height*0.015,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                              
                                                          ),
                                                        ),
                                                      ),
                              
                                                    ],
                                                  ),
                                                ),
                                                                    )
                                                
                                              
                                              
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ):null,
                                  ),
                              
                              
                          ),
                          
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