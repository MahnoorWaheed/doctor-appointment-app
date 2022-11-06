import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/utils/utils.dart';

class Fields extends StatelessWidget {
  String? label;
  Icon? icon;
  IconData? myIconData;
  TextEditingController? controller;
  String? Function(String?)? myValidator;
  Widget? suffIcon;
  bool? obscureText =false;
   Fields({
    Key? key,
    this.label,
    this.icon,
   this.controller,this.myValidator, this.suffIcon,
     this.obscureText, this.myIconData, required String? Function(dynamic value) validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:25.0, top: 5, right: 25),
      child: SingleChildScrollView(
        child: TextFormField(
          controller: controller!,
        obscureText: obscureText!,
        decoration: InputDecoration(
                             prefixIcon: Padding(
                                         padding: const EdgeInsets.only(right: 26 ),
                                           child: Icon(myIconData,color:Colors.grey.shade600 ,size: 22,),
                                         ),
                             label: Text(label!, style: GoogleFonts.poppins(fontSize: 13),),
                                         
                                         
                                         isDense: true,                      // Added this

                                         constraints: BoxConstraints(maxWidth: ScreenWidth(context)*0.85),
                        suffixIcon: suffIcon
                            ),
       
      validator: myValidator,
        ),
      ),
    );
  }
}