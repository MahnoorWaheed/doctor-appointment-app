import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appointment/utils/utils.dart';

class HomeContainer extends StatelessWidget {
  final IconData? iconData;
  final String? text;
  final String image;
  double? height, width, fontSize, imgheight;
  VoidCallback? ontap;
    HomeContainer({
    this.iconData,
    this.text, required this.image,
    this.ontap, this.height, this.width, this.fontSize, this.imgheight
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height:height??70,
        width: width??70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow:  [
            BoxShadow(
              color: Colors.grey.shade300,
               offset: Offset(
                 0.0,
                 0.0,
               ),
               blurRadius: 5.0,
               
            ),
          ],
    
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            // Icon(iconData, color: Theme.of(context).appBarTheme.backgroundColor, size: 35,),
            SvgPicture.asset(image,
            color: Theme.of(context).appBarTheme.backgroundColor,
            height: imgheight??30,
            ),
            
            Container(
              width: ScreenWidth(context)*0.8,
              child: Center(
                child: Text(text!, 
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).appBarTheme.backgroundColor,fontSize: fontSize??7, 
                  fontWeight: FontWeight.w600
                ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

