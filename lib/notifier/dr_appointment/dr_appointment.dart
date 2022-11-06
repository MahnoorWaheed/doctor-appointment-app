// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctor_appointment/models/doctor_appontment_model/doctor_appointment_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';


// class DrAppointmentProvider with ChangeNotifier{

// DrAppointmentProvider(){
//   getAppointment();
// }

// List<DrAppointmentModel> appointments = [];
// bool _dataisLoaded= false;

// bool get dataisLoaded=> _dataisLoaded;
// final _auth = FirebaseAuth.instance;

// setloadeddata(bool val){
// _dataisLoaded= val;
// notifyListeners();
// }
// Future getAppointment() async {
//   appointments.clear();
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//     final _auth = FirebaseAuth.instance;

//     final querySnapshot = await firestore
//         .collection("add_appointment")
//         .doc(_auth.currentUser!.email)
//         .collection('appointment_reminder').where("appointment_Status" == 'complete')
//         .get();
//         if(querySnapshot.docs.isNotEmpty){
//           querySnapshot.docs.forEach((doc) {
//             final drAppointmentsNotify = DrAppointmentModel.fromJson(doc.data());
//             print(drAppointmentsNotify.name);
//             appointments.add(drAppointmentsNotify);
//             setloadeddata(true);
//         notifyListeners();
//           });
//         }
//         notifyListeners();
//         return appointments;
//         }
// }