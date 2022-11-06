import 'package:doctor_appointment/screens/AppointmentScreen/Appoinments_details.dart';
import 'package:doctor_appointment/screens/AppointmentScreen/appointments.dart';
import 'package:doctor_appointment/screens/Home/Drawer%20Folder/notification_tab/appoinment_noti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:doctor_appointment/utils/global.dart';

import 'package:doctor_appointment/utils/utils.dart';
import 'package:page_transition/page_transition.dart';

class BottomNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
                        bottom: 0,
                        left: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: ScreenHeight(context)*0.07,
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                               
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                )),
                            width: ScreenWidth(context)*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                    GestureDetector(
                                        onTap: () async {
                                          navigatorKey.currentState!.pushReplacement(
                  
                  PageTransition(
                      type: PageTransitionType.fade, child: HomePage()));
                                        },
                                        child: Container(
                                          width: ScreenWidth(context)*0.14,
                                          height: ScreenHeight(context)*0.07,
                                          
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).appBarTheme.backgroundColor,
                                            borderRadius: BorderRadius.circular(50),
                                             boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 0),
                                      blurRadius: 5,
                                      spreadRadius: 3.0
                                      )
                                ],
                                          ),
                                          child: Center(
                                            child: FaIcon(
                                              Icons.home,
                                              size: 28,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                    
                                
                                  
                                    GestureDetector(
                                        onTap: () async {
                                           navigatorKey.currentState!.pushReplacement(
                 
                  PageTransition(
                      type: PageTransitionType.fade, child: Appointments()));
                                        },
                                        child: Container(
                                         width: ScreenWidth(context)*0.14,
                                          height: ScreenHeight(context)*0.07,
                                            decoration: BoxDecoration(
                                            color: Theme.of(context).appBarTheme.backgroundColor,
                                            borderRadius: BorderRadius.circular(50),
                                             boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 0),
                                      blurRadius: 5,
                                      spreadRadius: 3.0
                                      )
                                ],
                                          ),
                                          child: const Center(
                                            child: FaIcon(
                                              
                                              Icons.alarm,
                                              size: 28,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )), 
                                        
                                  GestureDetector(
                                          
                                        onTap: () async {
                                          navigatorKey.currentState!.pushReplacement(
                  
                  PageTransition(
                      type: PageTransitionType.fade, child: AppointmentsUpComing()));
                                          
                                        },
                                        child: Container(
                                          width: ScreenWidth(context)*0.14,
                                          height: ScreenHeight(context)*0.07,
                                            decoration: BoxDecoration(
                                            color: Theme.of(context).appBarTheme.backgroundColor,
                                            borderRadius: BorderRadius.circular(50),
                                             boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 0),
                                      blurRadius: 5,
                                      spreadRadius: 3.0
                                      )
                                ],
                                          ),
                                          child: Center(
                                            child: FaIcon(
                                              Icons.calendar_month,
                                              size: 28,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  
                                  
                                  ],
                                ),

                          ),
                        ));
  }
}