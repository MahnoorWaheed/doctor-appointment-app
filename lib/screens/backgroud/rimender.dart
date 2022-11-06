import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:doctor_appointment/widgets/action_button.dart';
import 'package:scheduled_timer/scheduled_timer.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class NotificationService {

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {

    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');



    //Initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        // onSelectNotification: onSelectNotification
    );
  }

  //  onSelectNotification(String? payload) async {
  //   //Navigate to wherever you want
  // }


   requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  Future<void> showNotifications({id, title, body, payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,
    
    );
    await flutterLocalNotificationsPlugin.show(
    id, title, body, platformChannelSpecifics,
        payload: payload);
  }


  Future<void> scheduleNotifications({id, title, body, time,token, required type,required doc_id}) async {

    try{
  
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(time, tz.local),
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'your channel id', 'your channel name',
                  channelDescription: 'your channel description',
                 // sound: 
                  
                  )),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          
         
          
          );

          ScheduledTimer myTimer;

          myTimer = ScheduledTimer(
            id: time.toString(), 
            onExecute: (){
              print('Executing myTimer');
              sendNotification(id, title, body,token);
              print("Type is: $type");
              if(type=='appointment'){
              print("Type is: $type");
              FirebaseFirestore.instance.collection("add_appointment").
              doc(FirebaseAuth.instance.currentUser!.uid).
              collection("appointment_reminder").doc(doc_id).update({
                 'status': 2
              });


              }

              else {
                 print("Type is: $type");

              }
              
            },
          defaultScheduledTime: time,
          onMissedSchedule: (){
            print('myTimer missed the scheduled time');
            //myTimer.execute(); // Execute onExecute() immediately
          }
          );

          

               
    }catch(e){
      print(e);
    }

     

  }
   
  
  
    Future<void> cancelNotifications() async {
    await flutterLocalNotificationsPlugin.cancel(1);
    await flutterLocalNotificationsPlugin.cancel(2);
    await flutterLocalNotificationsPlugin.cancel(3);
    await flutterLocalNotificationsPlugin.cancel(4);
  }

  
  
  sendNotification(id, title, body,token) async{
    print(token);

final data = {
  'click_action':"FLUTTER_NOTIFICATION_CLICK",
  'id': id,
  'status': 'done',
  'title': title,
  "body" :body,
  //'time': time,
  // 'click_button': 'ok',
  // 'click_button': 'cancel'

  

};

try{
http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),

headers: <String, String>{
  'Content-Type':'application/json',
  
  'Authorization': 'key=AAAAyFZ0DbY:APA91bEznEpqKLxYTLvODJDBGuvIN53IQ23hZJJ7Zmh8ElRAHVH78PSETEimG_kWvyqewjKa37HzmZ0Cqd3se-p-IB8ygEItDhpVBAHJRJ5WCfu-FtfM4f1yoBnJf2j2uejElvjog4PA',
},
body: jsonEncode(<String, dynamic>{
'notification': <String, dynamic>{
  'title': title,
  'body':body},
  'priority': 'high',
  //'time':time,
  'data': data,
  'to':'$token',
  

}));
if(response.statusCode == 200){
  print("success");
   print(response.body);
}else{
  print("error");
}



}catch(e){}


  }

  
}