import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/utils.dart';

class SelectDataAndTime extends StatelessWidget {
  SelectDataAndTime({required this.start,required this.images});
  final String start;
  final String images;



  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(8.0),
      width: ScreenHeight(context) * 0.16,
      height: ScreenHeight(context) *0.045,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(5),
          color: Colors.grey.shade50,
         border: Border.all(
          color: Theme.of(context).appBarTheme.backgroundColor!,
         ),
         boxShadow: [
           BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 0),
                        color: Theme.of(context).appBarTheme.backgroundColor!,
                        )
         ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(child: Text(start,style: GoogleFonts.poppins(fontSize: 14, ),)),
          Image.asset(images,color: Colors.black,),


        ],
      ),
    );
  }
}