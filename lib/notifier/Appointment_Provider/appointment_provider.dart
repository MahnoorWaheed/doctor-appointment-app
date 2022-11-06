  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Appointments_Model/appointments_model.dart';
import '../../screens/backgroud/rimender.dart';

class AppointmentProvider extends ChangeNotifier {
  AppointmentProvider() {
    getAppointmentData();
    completeAppointment();
    cancelAppointment();
  }
  List<AppointmentModel> appointmentlist = [];
  List<AppointmentModel> completelist = [];
  List<AppointmentModel> cancellist = [];


  //for time update
  DateTime selectedDate = DateTime.now();
  final NotificationService _notificationService = NotificationService();
  DateTime fullDate = DateTime.now();
  String newTime = "Start Time";
  String start_date = "";

  bool _isAppointmentLoaded = false;
  bool get isAppointmentloaded => _isAppointmentLoaded;
  setAppointmentloated(bool val) {
    _isAppointmentLoaded = val;
    notifyListeners();
  }

  Future AddAppointment({
    required String name,
    required String start_date,
    required String start_time,
    required String end_date,
    required String end_time,
    required String reason,
    required String randomString,
    required int sortingid
  }) async {
    await FirebaseFirestore.instance
        .collection("add_appointment")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('appointment_reminder')
        .doc(randomString)
        .set({
      "name": name,
      "start_date": start_date,
      "start_time": start_time,
      "end_date": end_date,
      "end_time": end_time,
      "email": FirebaseAuth.instance.currentUser!.email,
      "reason": reason,
      "created_at": '',
      "deleted_at": '',
      "updated_at": "",
      "appointment_Status":'upcoming',
      "id": randomString,
      "status": 1,
      'sortingid':sortingid,
    });

    appointmentlist.add(AppointmentModel(
        created_at: "",
        deleted_at: "",
        email: FirebaseAuth.instance.currentUser!.uid.toString(),
        end_date: end_date,
        end_time: end_time,
        id: randomString,
        name: name,
        reason: reason,
        start_date: start_date,
        start_time: start_time,
        appointment_Status: "upcoming",
        status: 1,
        sortingid: sortingid,
        updated_at: ''));

    notifyListeners();
    setAppointmentloated(true);
    notifyListeners();
  }

  Future getAppointmentData() async {
    // appointmentlist.clear();
    var snapShot = await FirebaseFirestore.instance
        .collection('add_appointment')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("appointment_reminder").where('appointment_Status',
        isEqualTo: 'upcoming')
        .get();
    if (snapShot.docs.isNotEmpty) {
      snapShot.docs.forEach((element) {
        final modelData = AppointmentModel.fromJson(element.data());
        appointmentlist.add(modelData);
        setAppointmentloated(true);
        notifyListeners();
      });
      notifyListeners();
      return appointmentlist;
    }
  }


  //Reschedule Appointment
  Future RescheduleAppointment({
    required String name,
    required String start_date,
    required String newTime,
    required String id,
  }) async {
    await  FirebaseFirestore.instance
        .collection('add_appointment').doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('appointment_reminder').doc(id)
        .update({"appointment_Status":"upcoming",
                  'name':name,
                   'start_date':start_date,
                   'start_time':newTime,
                    'email':FirebaseAuth.instance.currentUser!.email,

    });

    notifyListeners();
    setAppointmentloated(true);
    getAppointmentData();
    notifyListeners();


  }


  //Time Update
  Future timeupdate({
  required String id,
    required String newTime,
    required String start_date,
})async{
    await FirebaseFirestore.instance.collection("add_appointment").
    doc(FirebaseAuth.instance.currentUser!.uid).collection('appointment_reminder').doc(id).update({
      'start_time': newTime,
      'start_date': start_date,
    });
    notifyListeners();
    setAppointmentloated(true);
    notifyListeners();
  }


  //reschedules work
  Future<DateTime> selectDate(BuildContext context,String id,String dr_name,String token2) async {

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
          fullDate = DateTimeField.combine(date, time);
          start_date = ("${date.day}/${date.month}/${date.year}");
          newTime = time.format(context).toString();
        //schedule a notification
        await _notificationService.scheduleNotifications(
          id: 1,
          title: "Appointment Reminder",
          body: "Today is your Appointment with ${dr_name}",
          token: token2,
          type: 'appointment',
          doc_id: id
          
        );
          await FirebaseFirestore.instance.collection("add_appointment").doc(FirebaseAuth.instance.currentUser!.uid).collection('appointment_reminder').doc(id).update({
            'start_time': newTime,
            'start_date': start_date,
          });
          notifyListeners();
          getAppointmentData();
          notifyListeners();
      }
      notifyListeners();
      return DateTimeField.combine(date, time);
    } else {
      notifyListeners();
      return selectedDate;
    }
  }
  //end work
//complete appointment
 Future completeAppointment()async{
    // completelist.clear();
   var snapShot = await FirebaseFirestore.instance.collection("add_appointment")
       .doc(FirebaseAuth.instance.currentUser!.uid)
       .collection('appointment_reminder').where('appointment_Status',
       isEqualTo: 'complete').get();
   if (snapShot.docs.isNotEmpty) {
     snapShot.docs.forEach((element) {
       final modelData = AppointmentModel.fromJson(element.data());
       completelist.add(modelData);
       setAppointmentloated(true);
       notifyListeners();
     });

     notifyListeners();
     return completelist;
   }
 }

 //cancel Appointment
  Future cancelAppointment()async{
    cancellist.clear();
    var snapShot = await FirebaseFirestore.instance.collection("add_appointment")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('appointment_reminder').where('appointment_Status',
        isEqualTo: 'cancel').get();
    if (snapShot.docs.isNotEmpty) {
      snapShot.docs.forEach((element) {
        final modelData = AppointmentModel.fromJson(element.data());
        cancellist.add(modelData);
        setAppointmentloated(true);
        notifyListeners();
      });

      notifyListeners();
      return cancellist;
    }
  }


  Future deleteappointment({required String id})async{
  await FirebaseFirestore
      .instance
      .collection(
      "add_appointment")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(
      'appointment_reminder')
      .doc(id)
      .delete();
  notifyListeners();
}
//complete status
  Future complete_status({
    required String randomid,
    required int index,
   })async{
    await FirebaseFirestore.instance
        .collection('add_appointment').doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('appointment_reminder').doc(randomid).update({"appointment_Status":"complete"});
   await appointmentlist.removeAt(index);
    notifyListeners();
    completeAppointment();
    notifyListeners();
  }


  //cancel status
  Future cancel_status({
    required String randomid,
    required int index,
  })async{
   await FirebaseFirestore.instance
        .collection('add_appointment').doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('appointment_reminder').doc(randomid).update({"appointment_Status":"cancel"});
   await appointmentlist.removeAt(index);
    notifyListeners();
   cancelAppointment();
   notifyListeners();

  }


}
