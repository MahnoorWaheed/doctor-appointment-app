import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class FieldTitle extends StatelessWidget {
  String? title;
  Color? textColor;
  double? fontSize;
  FontWeight? fontWeight;
   FieldTitle({
    Key? key,
    this.title,
    this.textColor, 
    this.fontSize,
    this.fontWeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title!, 
    style: GoogleFonts.poppins(
        fontSize: fontSize??20,
        fontWeight: fontWeight??FontWeight.w400, 
        color: textColor??Colors.grey
      ),
    );
  }
}