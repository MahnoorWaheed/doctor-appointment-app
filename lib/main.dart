
import 'package:doctor_appointment/Themes/theme_class.dart';
import 'package:doctor_appointment/screens/backgroud/notification.dart';
import 'package:doctor_appointment/screens/mahnoor/splashscreen.dart';
import 'package:doctor_appointment/utils/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:doctor_appointment/notifier/Appointment_Provider/appointment_provider.dart';
import 'package:doctor_appointment/notifier/firebase_provider.dart';

import 'package:doctor_appointment/screens/backgroud/rimender.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('_____A bg message just showed up :  ${message.messageId}');
}
Future main() async {



  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

 

//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
//   SystemUiOverlay.bottom
// ]);


  await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  //notification initialization and requesting permission
  await NotificationService().init(); //
  await NotificationService().requestIOSPermissions(); 
   LocalNotificationService.initialize();
 Provider.debugCheckInvalidValueType=null;
  int?  valueBlue,valueSpooky,valueGreen, valueOrange;
  SharedPreferences.getInstance().then((prefs) {
    runApp(
       MultiProvider(
          providers: [
           
            ChangeNotifierProvider<FirebaseProvider>(create: (ctx)=>FirebaseProvider()),
    
             ChangeNotifierProvider<AppointmentProvider>(create:  (context)=>AppointmentProvider()),
            
            
            
            

     ],
     child: const MyApp(),
  )
);
});
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //    WidgetsBinding.instance.addPostFrameCallback((_) {
  //   FirebaseAnalytics.instance.logEvent(name: "app-start");
  //   });

  // }
  @override
  void initState() {
    // TODO: implement initState
    
    // getCaretakerData();
    super.initState();

  FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    showDialog(
            context: navigatorKey.currentContext!,
            builder: (_) {
              return AlertDialog(
                title: Text(event.notification!.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(event.notification!.body.toString(), 
                    style: GoogleFonts.quicksand(
                      color: Theme.of(context).appBarTheme.backgroundColor
                      
                    ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(onPressed: (){
                          FirebaseFirestore.instance.collection('caretaker').
                           doc(event.notification!.body.toString()).update({
                                     
                                      'status': 1
                                    }).whenComplete((){
navigatorKey.currentState!.pop();
 });
                        }, child: Text("Accept"),
                        style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(90, 40),
                                      maximumSize: const Size(90, 40),
                                      primary: Theme.of(context).appBarTheme.backgroundColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0))),
                        ),
                        ElevatedButton(onPressed: (){
                          FirebaseFirestore.instance.collection('caretaker').
                          doc(event.notification!.body.toString()).update({
                                     
                                      'status': 0
                                    }).whenComplete(() {

                             navigatorKey.currentState!.pop(context);
                                    });
                        }, child: Text("Cancel"),
                        style: ElevatedButton.styleFrom(
                                       primary: Theme.of(context).appBarTheme.backgroundColor, // background
                                       onPrimary: Colors.white, 
                                      minimumSize: const Size(90, 40),
                                      maximumSize: const Size(90, 40),// foreground
                                     shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                     )
                                     ),
                        ),
                        
                        
                      ],
                    ),
                  
                    ],
                  ),
                ),
              );});}); 
  }
  @override
  Widget build(BuildContext context) {
   
    WidgetsFlutterBinding.ensureInitialized();
        return MaterialApp(
          navigatorKey: navigatorKey,
         debugShowCheckedModeBanner: false,
        
          title: 'Flutter Demo',
               themeMode:ThemeMode.system,
      theme: ThemeClass.lightTheme,
              builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0,
          padding:EdgeInsets.only(top: ScreenHeight(context)*0.045) 
          ),
          
        );
      },
          // initialRoute: AppRoutes.splashscreen,
          // routes: AppRoutes.appRoutes,
          home: SplashScreen(),
          );
        
        
  } 
}

