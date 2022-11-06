import 'dart:io';
import 'package:doctor_appointment/screens/Home/Drawer%20Folder/notification_tab/appoinment_noti.dart';
import 'package:doctor_appointment/screens/Home/Profile/change_password.dart';
import 'package:doctor_appointment/widgets/field_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/notifier/firebase_provider.dart';
import 'package:doctor_appointment/screens/Home/Drawer%20Folder/about/About.dart';
import 'package:doctor_appointment/screens/Home/Drawer%20Folder/contact_us/Contact_Us.dart';

import 'package:doctor_appointment/utils/global.dart';

import 'package:doctor_appointment/utils/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {

   MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User currentUser= FirebaseAuth.instance.currentUser!;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? imagePick;
  // var image;

   
@override
  void initState() {
    // TODO: implement initState
    // getUserData();
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     
    return Consumer<FirebaseProvider>(
      builder: (context, value, child) =>
       Drawer(
        shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
        backgroundColor: Colors.white,
        child: ListView(
          shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: <Widget>[
             
              Container(
                 height: ScreenHeight(context)*0.3,
                 width: ScreenWidth(context)*0.4,
                child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Stack(
                   
                    children: [
                      Positioned(
                        right: 10,
                        child: IconButton(onPressed: (){
                         navigatorKey.currentState!.push(
                    
                    PageTransition(
                        type: PageTransitionType.fade, child: ChangePassword()));
                        }, icon: FaIcon(Icons.settings, color: Theme.of(context).appBarTheme.backgroundColor,)),
                      ),
                      Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           
                    Center(
                      child: CircleAvatar(
                            radius: ScreenHeight(context)*0.06,
                            child: Provider.of<FirebaseProvider>(context, listen: false).getProfileImage(),
                            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                          // backgroundImage:
                          //   FileImage(File(Provider.of<GetProfileImageProvider>(context).image)),
                           
                         ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        height: ScreenHeight(context)*0.05,
                        width: ScreenWidth(context)*0.55,
                        child: Card(
                          
                           shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
                          color:Theme.of(context).appBarTheme.backgroundColor ,
                          child: Text(currentUser.displayName.toString(), 
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                                             style: GoogleFonts.poppins(
                              color:  Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                               
                            ),
                                             ),
                        ),
                      ),
                      ],
                      ),

                      
                    ],
                  ),
                 
                ),
              ),
               SizedBox(height: ScreenHeight(context)*0.05,),
              Padding(
                padding: const EdgeInsets.only(left:45.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: ScreenHeight(context)*0.4,
                      width: ScreenWidth(context)*0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         drawerIcons(context, Icons.notifications),
                         drawerIcons(context, Icons.info),
                         drawerIcons(context, Icons.contact_page),
                        
                       
                      
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenHeight(context)*0.4,
                      width: ScreenWidth(context)*0.45,
                      
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            child: Text(" Notifications", style: GoogleFonts.poppins(
                            color: Theme.of(context).appBarTheme.backgroundColor, fontSize: 20, 
                            fontWeight: FontWeight.w600
                          ),),
                          onPressed: (){
                             navigatorKey.currentState!.push(
                    
                    PageTransition(
                        type: PageTransitionType.fade, child: AppoinmentNotifications()));
                          },
                          ),
                          TextButton(
                            child: Text(" About", style: GoogleFonts.poppins(
                            color: Theme.of(context).appBarTheme.backgroundColor, fontSize: 20,
                             fontWeight: FontWeight.w600
                          ),),
                          onPressed: (){
                             navigatorKey.currentState!.push(
                    
                    PageTransition(
                        type: PageTransitionType.fade, child: About()));
                          },
                          ),
                          TextButton(
                            child: Text(" Contact Us", style: GoogleFonts.poppins(
                            color: Theme.of(context).appBarTheme.backgroundColor, fontSize: 20,
                             fontWeight: FontWeight.w600
                          ),),
                          onPressed: (){
                             navigatorKey.currentState!.push(
                   
                    PageTransition(
                        type: PageTransitionType.fade, child: Contact_Us()));
                          },
                          ),
                         
                        ],
                      ),
                    )
                  ],
                ),
              ),

              
              
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:ScreenWidth(context)*0.1, vertical: ScreenHeight(context)*0.06,
                ),
                child: GestureDetector(
                  onTap: (){
                    value.logout(context);
                    value.logOut(context);
                    
                  },
                  child: Container(
                    height: ScreenHeight(context)*0.06,
                    width: ScreenWidth(context)*0.2,
                    
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Theme.of(context).appBarTheme.backgroundColor,
                     ),
                     child: Center(
                       child: Text("Logout", 
                       style: GoogleFonts.poppins(
                         color: Colors.white,
                         fontSize: 17
                       ),),
                     ),
                  ),
                ),
              ),
            
            ]
        ),
      ),
    );
  }

  Container drawerIcons(BuildContext context, IconData iconData) {
    return Container(
                        width: ScreenWidth(context)*0.14,
                                        height: ScreenHeight(context)*0.06,
                                          decoration: BoxDecoration(
                                          color: Theme.of(context).appBarTheme.backgroundColor,
                                          borderRadius: BorderRadius.circular(50),
                                           boxShadow:const  [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 0),
                                    blurRadius: 5,
                                    spreadRadius: 3.0
                                    )
                              ],
                                        ),
                        child: Icon(iconData, color: Colors.white,));
  }
}