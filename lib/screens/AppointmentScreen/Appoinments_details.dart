import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/screens/Home/main_home/home.dart';
import 'package:doctor_appointment/screens/backgroud/rimender.dart';
import 'package:intl/intl.dart';

import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/widgets/bottom_nav.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../notifier/Appointment_Provider/appointment_provider.dart';
import '../../../widgets/appointmentslimited/limited_dialog.dart';
import '../../../widgets/appointmentslimited/select_data_time.dart';
import 'appointments.dart';


class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  int _index = 2;

  DateTime _selectedValue = DateTime.now();
  final limited=LimitedDialog();

  String token2 = '';

  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // int count_reminder = 1;

  final _formKey = GlobalKey<FormState>();

  TextEditingController reason = TextEditingController();

  

  final NotificationService _notificationService = NotificationService();
  DateTime selectedDate = DateTime.now();
  DateTime fullDate = DateTime.now();
  DateTime fullDate2 = DateTime.now();
  // String start_time = "9:00 am";
  // String end_time = "9:00 am";
   String popvalue = '';
  //
  // String start_date = '15/10/2022';
  // String end_date = '15/10/2022';
  var start_time = DateFormat('hh:mm a').format(DateTime.now());
  var end_time = DateFormat('hh:mm a').format(DateTime.now().add(Duration(hours: 1)));
  String start_date = DateFormat.yMd().format(DateTime.now());
  String end_date = DateFormat.yMd().format(DateTime.now());


  var time;
  var date;
  var date2;
  var time2;

  var random;

  TextEditingController dr_name = TextEditingController();
  var dropdownselectedCategory;
  final List<String> itemscategory = [
    'Allergists/Immunologists',
    'Anesthesiologists',
    'Cardiologists',
    'Colon and Rectal Surgeons',
    'Critical Care Medicine Specialists',
    'Dermatologists',
    'Endocrinologists',
    'Emergency Medicine Specialists',
    'Family Physicians',
    'Gastroenterologists',
    'Geriatric Medicine Specialists',
    'Hematologists',
    'Hospice and Palliative Medicine Specialists',
    'Infectious Disease Specialists',
    'Internists',
    'Medical Geneticists',
    'Nephrologists',
    'Neurologists',
    'Obstetricians and Gynecologists',
    'Oncologists',
    'Ophthalmologists',
    'Osteopaths',
    'Otolaryngologists',
    'Pathologists',
    'Pediatricians',
    'Physiatrists',
    'Plastic Surgeons',
    'Podiatrists',
    'Preventive Medicine Specialists',
    'Psychiatrists',
    'Pulmonologists',
    'Radiologists',
    'Rheumatologists',
    'Sleep Medicine Specialists',
    'Sports Medicine Specialists',
    'General Surgeons',
    'Urologists'

  
  ];
  Future<DateTime> _selectDate(BuildContext context) async {

    if (date != null) {

      if (time != null) {

        if (time.format(context).toString() !=
            DateFormat("hh:mm a").format(DateTime.now())) {
          setState(() {
            fullDate = DateTimeField.combine(date, time);
            start_time = time.format(context);
            start_date = ("${date.day}/${date.month}/${date.year}");


             DateTime t =DateTime.parse(fullDate.toString()).add(Duration(hours: 1));
             // end_time = DateFormat("hh:mm a").format(t);
            print("current time : ${time.format(context).toString()}");
            print("current time2 : ${DateFormat("hh:mm a").format(DateTime.now())}");
          });
          //TODO
          //schedule a notification

        } else {
          print("reminder not set");

         limited.remaindernot_set(context);
        }
      }
      return DateTimeField.combine(date, time);
    } else {
      return selectedDate;
    }
  }

  Future<DateTime> _selectDate2(BuildContext context) async {

    if (date2 != null) {
      // time2 = await showTimePicker(
      //    context: context,
      //    initialTime: TimeOfDay.fromDateTime(selectedDate),
      //  );

      if (time2 != null && fullDate != DateTimeField.combine(date2, time2)) {
        setState(() {
          fullDate2 = DateTimeField.combine(date2, time2);
          end_time = time2.format(context);
          end_date = ("${date2.day}/${date2.month}/${date2.year}");
        });

      } else {
        print("no time");
        limited.notimePicker(context);
      }
      return DateTimeField.combine(date2, time2);
    } else {
      return selectedDate;
    }
  }

  Future<SharedPreferences> sprefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCount();
    });

    print(token2);
  }

  int count_reminder = 1;
  int count = 1;
  // int maxClick = 15;
  bool absorbing_check = false;

  getCount() async {
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('add_appointment')
        .doc(_auth.currentUser!.uid)
        .collection('appointment_reminder')
        .get();
    final int documents = qSnap.docs.length;
    print("hello documents $documents");

    setState(() {
      count_reminder = documents;
      count = documents;
    });
    print("hello count");
    print(count_reminder);
  }

  bool _isButtonDisabled = false;

  Future<bool> backclose() async {
    // SystemNavigator.pop();
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          child: HomePage(),
          type: PageTransitionType.fade,
        ),
            (route) => false);

    return true;
  }

  void _incrementCounter() async {
    _selectDate(context);
    print("count : $count");
  }

  void _incrementCounter1() async {
    _selectDate2(context);
    print("count : $count");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backclose,
      child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text("Appointments"),
             titleTextStyle: GoogleFonts.poppins(
              color:Theme.of(context).appBarTheme.backgroundColor,
             fontSize:20,
             fontWeight:FontWeight.w700
             ),    
                
                leading: IconButton(
                    onPressed: () {
                      //  _scaffoldKey.currentState!.openDrawer();
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: AppointmentsUpComing(),
                            type: PageTransitionType.fade,
                          ),
                              (route) => false);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.grey)),
              ),
             
             
              body: Center(
                  child: Stack(
                    children: [
                      
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          
                         
                         
                          Center(
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height *
                                        0.010,),

                                    Container(
                                       width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.09,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow:  <BoxShadow>[
                        BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 0),
                        color: Theme.of(context).appBarTheme.backgroundColor!,
                        )
                        ]),
                                      child: TextFormField(
                                        validator: ((value) {
                                          if (value!.isEmpty) {
                                            return 'Cannot be blank';
                                          }
                                          return null;
                                        }),
                                        maxLength: 18,
                                        maxLines: 2,
                                        keyboardType:
                                        TextInputType.name,
                                        controller: dr_name,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          hintText: 'Doctor Name',
                                          hintStyle: GoogleFonts.poppins(
                            textStyle: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize:
                                    ScreenHeight(context) * 0.02,
                                fontWeight: FontWeight.w900),
                          ),
                                          counterText:
                                          (dr_name.text.length != 18)
                                              ? ""
                                              : "limit exceeds",
                                          counterStyle:
                                          GoogleFonts.poppins(
                                            color:
                                            Colors.red,),
                                          contentPadding: const EdgeInsets.all(12),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide.none
                                          )
                                          
                                        ),


                                      ),
                                    ),

                                    //Reason
                                    SizedBox(height: MediaQuery.of(context).size.height *
                                        0.010,),
                                    Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:  Container(
                             width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.09,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color.fromARGB(255, 0, 0, 0),
                        boxShadow:  <BoxShadow>[
                        BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 0),
                        color: Theme.of(context).appBarTheme.backgroundColor!,
                        )
                        ]),
                    
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        
                        isExpanded: true,
                        hint: Row(
                        children: [
                        Text(
                          'Specialization',
                          style: GoogleFonts.poppins(
                            textStyle: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize:
                                    ScreenHeight(context) * 0.02,
                                fontWeight: FontWeight.w900),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        ],
                        ),
                        items: itemscategory
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: GoogleFonts.poiretOne(
                                  textStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize:
                                          ScreenHeight(context) *
                                              0.02,
                                      fontWeight: FontWeight.w700),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                        value: dropdownselectedCategory,
                        onChanged: (value) {
                        setState(() {
                        dropdownselectedCategory = value as String;
                        });
                        },
                        icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 25.0,
                        ),
                        iconOnClick:  Icon(
                        Icons.keyboard_arrow_up,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        size: 25.0,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 30,
                        buttonWidth: ScreenWidth(context)* 0.5,
                        buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                        buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                        color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 10, right: 10),
                        dropdownMaxHeight:
                        ScreenHeight(context) * 0.3,
                        dropdownWidth: ScreenWidth(context) * 0.5,
                        dropdownPadding: null,
                        dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 8,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, 0),
                      ),
                    ),
               
               
                  ),
                        ),

                                   
    

                                    



                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        
                                        Padding(
                                          padding:  EdgeInsets.symmetric(horizontal:ScreenWidth(context)*0.0,vertical: ScreenHeight(context)*0.02),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("Start Date",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                                              
                                              Text("End Date",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),)
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                                onTap: () async{
                                                 
                                                     //_incrementCounter();
                                                     date= await showDatePicker(
                                                         context: context,
                                                         // initialDatePickerMode: ,
                                                         initialEntryMode: DatePickerEntryMode.input,
                                                         initialDate: selectedDate,
                                                         firstDate: DateTime.now(),
                                                         lastDate: DateTime(2050));
                                                     start_date = ("${date.day}/${date.month}/${date.year}");

                                                  

                                                },
                                                child: SelectDataAndTime(start: start_date,images:'assets/date-solid.png' ,)),
GestureDetector(
                                                onTap: () async{

                                                    date2 = await showDatePicker(
                                                        context: context,
                                                        initialEntryMode: DatePickerEntryMode.input,
                                                        initialDate: selectedDate,
                                                        firstDate: DateTime.now(),
                                                        lastDate: DateTime(2050));
                                                   // _incrementCounter1();
                                                     end_date = ("${date2.day}/${date2.month}/${date2.year}");

                                                },
                                                child: SelectDataAndTime(start:end_date,images:'assets/date-solid.png' ,)),

                                            
                                            
                                          ],
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(horizontal:ScreenWidth(context)*0.0,vertical: ScreenHeight(context)*0.02),
                                          child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("Start Time",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                                              
                                              Text("End Time",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),)
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(

                                                onTap: () async{
                                                  

                                                   // if (date != null) {
                                                      print('time =$time');
                                                         time= await showTimePicker(
                                                              context: context,
                                                         initialEntryMode: TimePickerEntryMode.input,
                                                         initialTime: TimeOfDay.fromDateTime(selectedDate),
                                                       );
                                                         if(time==TimeOfDay.fromDateTime(selectedDate)){
                                                           limited.remaindernot_set(context);
                                                           time=null;
                                                           print('else time =$time');
                                                         }else {
                                                           _incrementCounter();
                                                         }



                                                  
                                                },
                                                child: SelectDataAndTime(start:start_time,images:'assets/time.png',)),
                                            
                                            GestureDetector(
                                                onTap: () async{

                                                    //if(date2 !=null){

                                                      time2 = await showTimePicker(
                                                        context: context,
                                                        initialEntryMode: TimePickerEntryMode.input,
                                                        initialTime: TimeOfDay.fromDateTime(selectedDate),
                                                      );
                                                      print('time2 =$time2');
                                                      if (time2 != null && fullDate != DateTimeField.combine(date2, time2)){
                                                        //_incrementCounter1();
                                                        fullDate2 = DateTimeField.combine(date2, time2);
                                                        if(fullDate2.isAfter(fullDate)){
                                                          end_time = time2.format(context);
                                                        }else{
                                                          print("no time");
                                                          limited.notimePicker(context);
                                                          time2=null;
                                                        }
                                                       // end_date = ("${date2.day}/${date2.month}/${date2.year}");
                                                       // end_time=time2.format(context).toString();
                                                      }else{
                                                        print("no time");
                                                        //limited.notimePicker(context);
                                                      }






                                                },
                                                child: SelectDataAndTime(start:end_time,images:'assets/time.png',)),

                                          ],
                                        ),


                                      ],
                                    ),
                                   
                                    SizedBox(
                                      height: ScreenHeight(context) * 0.0225,
                                    ),
                                    Lottie.asset("assets/43967-calendar-appointment.json", height: ScreenWidth(context)*0.3),
                                    GestureDetector(
                                      onTap: () async {

                                        
                                        if (_formKey.currentState!.validate()) {
                                          if (date!=null &&  time!=null && date2!=null && time2!=null)
                                          {
                                            fullDate2 = DateTimeField.combine(date2, time2);
                                            if(fullDate != DateTimeField.combine(date2, time2) && fullDate2.isAfter(fullDate)) {
                                              appointmentsCheck();
                                              const _chars =
                                                  'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                                              Random _rnd = Random();
                                              String getRandomString(
                                                  int length) =>
                                                  String.fromCharCodes(
                                                      Iterable.generate(
                                                          length,
                                                              (_) =>
                                                              _chars
                                                                  .codeUnitAt(
                                                                  _rnd
                                                                      .nextInt(
                                                                      _chars
                                                                          .length))));
                                              var randomString = getRandomString(
                                                  5);
                                                  random=randomString;
                                              Provider.of<
                                                  AppointmentProvider>(
                                                  context, listen: false)
                                                  .AddAppointment(
                                                  name: dr_name.text,
                                                  start_date: start_date,
                                                  start_time: start_time,
                                                  end_date: end_date,
                                                  end_time: end_time,
                                                  reason: dropdownselectedCategory,
                                                  randomString: randomString,
                                                  sortingid: DateTime
                                                      .now()
                                                      .millisecondsSinceEpoch);

                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  PageTransition(
                                                    child: AppointmentsUpComing(),
                                                    type: PageTransitionType
                                                        .fade,
                                                  ),
                                                      (route) => false);
                                            }else{
                                              print('no time picker');
                                              limited.notimePicker(context);
                                            }
                                          }

                                          else {
                                            limited.showDialogBox(context);
                                          }
                                        }
                                        
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.52,
                                        height: MediaQuery.of(context).size.height * 0.052,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).appBarTheme.backgroundColor,
                                        ),
                                        child: Center(
                                            child: Text(
                                              "Make an Appointment",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: ScreenHeight(context) * 0.02,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenHeight(context) * 0.0635,
                          ),

                          SizedBox(height: ScreenHeight(context) * 0.1),
                        ],
                      ),
                      BottomNavbar()
                    ],
                  )),
            ),
          )),
    );
  }
  Future appointmentsCheck()async{
    await _notificationService
        .scheduleNotifications(
      id: 1,
      title: "Appointment Reminder",
      body:
      "Today is your Appointment with ${dr_name.text}",
      time: fullDate,
      token: token2,
      type: 'appointment',
      doc_id: random
      
    );

    print("after 1 hr");
    print(fullDate);
    await _notificationService.scheduleNotifications(
        id: 2,
        title: "Appointment Reminder",
        body:
        "Today's your Appointment with ${dr_name.text} after 1 hour",
        token: token2,
        time: fullDate.subtract(Duration(hours: 1)),
        type: 'appointment', 
        doc_id: random

        );
    //End Time
    await _notificationService
        .scheduleNotifications(
      id: 3,
      title: "Appointment Reminder",
      body:
      "Today's your Appointment with ${dr_name.text}",
      time: fullDate2,
      token: token2,
      type: 'appointment',
      doc_id: random
    );

    print("after 1 hr");
    print(fullDate2);
    await _notificationService.scheduleNotifications(
        id: 4,
        title: "Appointment Reminder",
        body:
        "Today's your Appointment with ${dr_name.text} after 1 hour",
        token: token2,
        time: fullDate2.subtract(Duration(hours: 1)),
        type: 'appointment',
        doc_id: random
        );
  }
}


