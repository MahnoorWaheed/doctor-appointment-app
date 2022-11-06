import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/screens/AppointmentScreen/appointments.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:doctor_appointment/widgets/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import '../../../../notifier/Appointment_Provider/appointment_provider.dart';
import '../../../../utils/utils.dart';
import '../Appoinments_details.dart';

class Completed extends StatefulWidget {

  Completed({ Key? key }) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                    Text("Complete Appointments", style: GoogleFonts.poppins(
  
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
                                  itemCount: appointments.completelist.length,
                                  itemBuilder: ((context, index){
                         
                                    return Padding(
                                      padding: EdgeInsets.only(left:10.0,top: 8,right: 10),
                                      child: Container(
                                        height: ScreenHeight(context)*0.1,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Theme.of(context).appBarTheme.backgroundColor
                                        ),
                                        //  width: ScreenWidth(context)*0.1,
                                        //  color: Colors.blue,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                         
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(appointments.completelist[index].name, style: GoogleFonts.poppins(
                                                      fontSize: MediaQuery.of(context).size.height*0.023,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold
                         
                                                  ),),
                                                  
                                                  Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      SizedBox(width: ScreenWidth(context)*0.03,),
                                                      Image.asset('assets/date-solid.png'),
                                                      SizedBox(width: ScreenWidth(context)*0.02,),
                                                      Text(appointments.completelist[index].start_date,
                                                        style: GoogleFonts.poppins(
                                                          fontSize: MediaQuery.of(context).size.height*0.015,
                                                          color: Colors.white,
                         
                                                        ),
                                                      ),
                                                      SizedBox(width: ScreenWidth(context)*0.043,),
                                                      Image.asset('assets/time.png'),
                                                      SizedBox(width: ScreenWidth(context)*0.025,),
                                                      Text(appointments.completelist[index].start_time,
                                                        style: GoogleFonts.poppins(
                                                          fontSize: MediaQuery.of(context).size.height*0.015,
                                                          color: Colors.white,
                         
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:5.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: ()async{
                                                      print('delete');
                                                      await appointments.deleteappointment(id: appointments.completelist[index].id);
                                                      await appointments.completelist.removeAt(index);
                         
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width*0.23,
                                                      height: MediaQuery.of(context).size.height*0.031,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        color: Colors.white,
                         
                                                      ),
                                                      child: Center(child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset("assets/delete.svg",
                                                            height: MediaQuery.of(context).size.height*0.02,
                                                            color: Theme.of(context).appBarTheme.backgroundColor,
                                                          ),
                                                          SizedBox(width: ScreenWidth(context)*0.015,),
                                                          Text("Delete",
                                                            style: GoogleFonts.poppins(
                                                                color:  Theme.of(context).appBarTheme.backgroundColor,
                                                                fontSize: MediaQuery.of(context).size.height*0.015,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                    ),
                                                  ),
                         
                         
                                                ],
                                              ),
                                            )
                         
                                          ],
                                        ),
                                      )
                         
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
           ),
        ),
      ),
    );
  }
}