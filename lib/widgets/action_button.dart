import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  String? title;
  VoidCallback? ontap;
  Color? buttonColor;
  double? buttonHeight;
  double? buttonWidth, fontSize;
  Widget? actionChild;
  BorderRadius? borderRadius;

   ActionButton({ Key? key, this.ontap, this.title , this.buttonColor, 
   this.buttonHeight, this.buttonWidth, this.actionChild, this.borderRadius, 
   this.fontSize
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ignore: sort_child_properties_last
      child: Center(
        child: Container(
                                              height: buttonHeight??MediaQuery.of(context).size.height * 0.07,
                                              width:buttonWidth?? MediaQuery.of(context).size.width * 0.88,
                                              decoration:  BoxDecoration(
                                                  color: Theme.of(context).appBarTheme.backgroundColor,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.black26,
                                                        offset: Offset(2, 2),
                                                        blurRadius: 5)
                                                  ],
                                                  borderRadius: borderRadius??BorderRadius.circular(10),
                                                  ),
                                                  
                                              child: Center(
                                                child: Text(
                                                  title!,
                                                  style: GoogleFonts.poppins(
                                                   // color: Color(0xff57b547),
                                                   color: Colors.white,
                                                    fontSize:fontSize?? 20,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
      ),
      onTap: ontap,
    );
  }
}