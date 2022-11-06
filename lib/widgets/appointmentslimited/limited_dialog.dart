import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/utils.dart';

class LimitedDialog{

  void showDialogBox(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor:
            Colors.white,
            insetPadding:
            const EdgeInsets
                .all(15),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius
                    .circular(
                    20.0)), //this right here
            child: SizedBox(
              height: ScreenHeight(
                  context) *
                  0.27,
              width: ScreenWidth(
                  context) *
                  0.4,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .center,
                children: [
                  Padding(
                    padding: const EdgeInsets
                        .only(
                        top: 10,
                        bottom:
                        10),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                      children: [
                        // LargeText(
                        //   text: 'Pick Image',
                        //   color: Colors.white,
                        // ),
                        Text(
                            'Date and Time !',
                            style:
                            GoogleFonts.poppins(
                              color:
                              Theme.of(context).appBarTheme.backgroundColor,
                              fontWeight:
                              FontWeight.bold,
                              fontSize:
                              ScreenHeight(context) * 0.028,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets
                        .only(
                        left:
                        30,
                        right:
                        30),
                    child:
                    Divider(
                      height: 2,
                      color: Theme.of(
                          context)
                          .primaryColor,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets
                          .only(
                          left: 0,
                          top:
                          40),
                      //width: ScreenUtils.screenwidth(context) * 0.7,
                      child: Text(
                        "Date and Time Must be Enter",
                        style: GoogleFonts.poppins(
                            color: Theme.of(context)
                                .primaryColor,
                            fontWeight: FontWeight
                                .bold,
                            fontSize:
                            ScreenHeight(context) * 0.02),
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(
                          context)
                          .pop();
                    },
                    child:
                    Padding(
                      padding: const EdgeInsets
                          .only(
                          top:
                          40.0,
                          right:
                          0,
                          left:
                          0),
                      child: Container(
                          height: ScreenHeight(context) * 0.04,
                          width: ScreenWidth(context) * 0.27,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(15.0),
                            color:
                            Theme.of(context).appBarTheme.backgroundColor,
                          ),
                          child: Center(
                            child:
                            Text(
                              'OK',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: ScreenHeight(context) * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }



   remaindernot_set(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)), //this right here
              child: SizedBox(
                height: ScreenHeight(context) * 0.35,
                width: ScreenWidth(context) * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text('Reminder not set !',
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).appBarTheme.backgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenHeight(context) * 0.028,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Divider(
                        height: 2,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 0, top: 40),
                        //width: ScreenUtils.screenwidth(context) * 0.7,
                        child: Text(
                          "You should add reminder after 1 hr",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).appBarTheme.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenHeight(context) * 0.02),
                        )),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, right: 0, left: 0),
                          child: Container(
                              height: ScreenHeight(context) * 0.04,
                              width: ScreenWidth(context) * 0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Theme.of(context).appBarTheme.backgroundColor,
                              ),
                              child: Center(
                                child: Text(
                                  'OK',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize:
                                      ScreenHeight(context) * 0.02,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  
  void notimePicker(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)), //this right here
              child: SizedBox(
                height: ScreenHeight(context) * 0.34,
                width: ScreenWidth(context) * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // LargeText(
                          //   text: 'Pick Image',
                          //   color: Colors.white,
                          // ),
                          Text('End Time !',
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).appBarTheme.backgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenHeight(context) * 0.028,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Divider(
                        height: 2,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 10, top: 40,right: 10),
                        //width: ScreenUtils.screenwidth(context) * 0.7,
                        child: Text(
                          "Start date must be before end date",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).appBarTheme.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenHeight(context) * 0.02),
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, right: 0, left: 0),
                        child: Container(
                            height: ScreenHeight(context) * 0.04,
                            width: ScreenWidth(context) * 0.27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Theme.of(context).appBarTheme.backgroundColor,
                            ),
                            child: Center(
                              child: Text(
                                'OK',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: ScreenHeight(context) * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  
  
  void showNameDatetime({required BuildContext context,
    required String name,
    required String reason,
    required String date,
    required String time,
  }){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.0)), //this right here
              child: SizedBox(
                height: ScreenHeight(context) * 0.40,
                width: ScreenWidth(context) * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text('Appointments',
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).appBarTheme.backgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenHeight(context) * 0.028,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Divider(
                        height: 2,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(

                        children: [

                          Row(
                            children: [
                              Text(
                                "Name:      ",
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).appBarTheme.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenHeight(context) * 0.02),
                              ),
                              Text(
                                name,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,

                                    fontSize: ScreenHeight(context) * 0.02),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Reason:   ",
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).appBarTheme.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenHeight(context) * 0.02),
                              ),
                              Container(
                                width:ScreenWidth(context) * 0.47 ,
                                child: Text(
                                  reason,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: ScreenHeight(context) * 0.02),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                "Date:       ",
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).appBarTheme.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenHeight(context) * 0.02),
                              ),
                              Text(
                                date,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,

                                    fontSize: ScreenHeight(context) * 0.02),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                "Time:       ",
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).appBarTheme.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenHeight(context) * 0.02),
                              ),
                              Text(
                                time,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,

                                    fontSize: ScreenHeight(context) * 0.02),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                             bottom: 10),
                        child: Container(
                            height: ScreenHeight(context) * 0.04,
                            width: ScreenWidth(context) * 0.27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Theme.of(context).appBarTheme.backgroundColor,
                            ),
                            child: Center(
                              child: Text(
                                'OK',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: ScreenHeight(context) * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
 
 
  }



}