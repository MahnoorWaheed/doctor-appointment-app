import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_appointment/screens/AppointmentScreen/Appoinments_details.dart';
import 'package:doctor_appointment/widgets/action_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/notifier/firebase_provider.dart';
import 'package:doctor_appointment/screens/AppointmentScreen/appointments.dart';
import 'package:doctor_appointment/screens/backgroud/notification.dart';
import 'package:doctor_appointment/utils/global.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/widgets/drawer_widget.dart';
import 'package:doctor_appointment/widgets/home_container.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  bool backFrom;
   HomePage({ Key? key, this.backFrom=false}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


TextEditingController searchController= TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
DateTime _lastExitTime = DateTime.now();
FirebaseAuth _auth = FirebaseAuth.instance;
String? navigations;


final String message = DateTime.now().hour < 12 ?
  "Good Morning":DateTime.now().hour<5?"Good Evening": "Good Afternoon";
  

  final List<String> imagesList = [
    'assets/c1.png',
    'assets/c2.png',
    'assets/c3.png',
   
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
 
    }); 

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
    
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
          },
          
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          appBar: AppBar(

            elevation: 0,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
             title: Text("${_auth.currentUser!.displayName}"),
             titleTextStyle: GoogleFonts.poppins(
              color:Colors.white,
             fontSize:20,
             fontWeight:FontWeight.w700
             ),
            
           leading: IconButton(onPressed: (){
             _scaffoldKey.currentState!.openDrawer();
           }, icon: Icon(Icons.menu, color: Colors.white,)),

           actions: [
            Padding(padding: EdgeInsets.all(10),
            child: Provider.of<FirebaseProvider>(context, listen: false).getProfileImage(),
            ),
            
           ],
          ),
          
          // Drawer is placed in widget folder drawer
          
          drawer: MyDrawer(),
          
          
          body: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                 Container(
                  height: ScreenHeight(context)*0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                 ),
                 
                SingleChildScrollView(
                  child: Consumer<FirebaseProvider>(
                    
                    builder: (context, homeProvider, child) {
                    
                    return Column(
                        children: [
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                  width: MediaQuery.of(context).size.width*0.4,
                                  height:MediaQuery.of(context).size.height*0.06,
                                  decoration:  BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:  [
                         BoxShadow(
                               color: Colors.grey.shade300,
                                    offset: Offset(
                                      2.0,
                                      1.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0,
                         ),
                       ]
                                  ),
                                  
                                  alignment: Alignment.center, // where to position the child
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:5.0, vertical: 5),
                                                 
                                    child: Text("Welcome!",
                                                 
                                     style: GoogleFonts.poppins(
                                       color: Theme.of(context).appBarTheme.backgroundColor,
                                       fontSize: ScreenHeight(context)*0.02
                                     ),
                                                     ),
                                  ),
                                ),
                               ),
                             
                             Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                  width: MediaQuery.of(context).size.width*0.4,
                                  height:MediaQuery.of(context).size.height*0.06,
                                  decoration:  BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:  [
                         BoxShadow(
                               color: Colors.grey.shade300,
                                    offset: Offset(
                                      2.0,
                                      1.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0,
                         ),
                       ]
                                  ),
                                  
                                  alignment: Alignment.center, // where to position the child
                                  child: _auth.currentUser!.displayName!=null?Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:5.0),
                                    child: Text("${_auth.currentUser!.displayName.toString()}.", 
                                    style: GoogleFonts.poppins(
                                             color: Theme.of(context).appBarTheme.backgroundColor,
                                              fontSize: ScreenHeight(context)*0.02
                                       ),
                                    ),
                                  ):
                                  Text("Guest", 
                                  style: GoogleFonts.poppins(
                                       color: Colors.white,
                                       fontSize: 18
                                     ),
                                  ),
                                ),
                               ),
                             
                             
                             ],
                           ),
                                  CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
        ),
        items: imagesList
            .map(
              (item) => Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
                               Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Container(
                     height: ScreenHeight(context)*0.45,
                     width: ScreenWidth(context)*0.9,
                   
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(30),
                       boxShadow:  [
                         BoxShadow(
                           color: Colors.grey.shade300,
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 0.0,
                         ),
                       ],
                     ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: ScreenWidth(context)*0.5,
                                child: reusableText(context, 'Have you forget your appointment with doctor again?')),
                              Lottie.asset("assets/16766-forget-password-animation.json", height: ScreenHeight(context)*0.1),
                            ],
                          ), 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: ScreenWidth(context)*0.5,
                                child: reusableText(context,"Don't worry! your health is our first priority")),
                                Lottie.asset("assets/92309-online-doctor.json", height: ScreenHeight(context)*0.1),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                 width: ScreenWidth(context)*0.5,
                                child: reusableText(context,"Here you can set Your appointment reminder.")),
                              Lottie.asset("assets/94910-greenish-arrow-down.json", height: ScreenHeight(context)*0.1, 
                              
                              ),
                              

                            ],
                          ), 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ActionButton(
                                  title: "Set Reminder",
                                  ontap: (){
                                    Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(builder: (ctx)=>Appointments()));
                                  },
                                  buttonWidth: ScreenWidth(context)*0.45,
                                ),
                              )
                            ],
                          )

                        ],
                      ),
                     
                               ),
                             ),],);}, ),),],),),),),);}

  Text reusableText(BuildContext context, String? text) {
    return Text(text!, 
                              style: GoogleFonts.poppins(color:Theme.of(context).appBarTheme.backgroundColor),
                              );
  }

Future<bool> onWillPop() async {
  DateTime now = DateTime.now();
  if (_lastExitTime == null ||
      now.difference(_lastExitTime) > Duration(seconds: 2)) {
    _lastExitTime = now;
    final snack =  SnackBar(
      content:  Text("Press the back button again to exist the app"),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
    return Future.value(false);
  }
  SystemNavigator.pop(); // add this.

  return Future.value(true);
}
}