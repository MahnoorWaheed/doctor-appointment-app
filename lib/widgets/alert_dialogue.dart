
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertDialogWidegt extends StatelessWidget {
  String? title;
  String? desc;
  VoidCallback? onTap;
   AlertDialogWidegt({
    Key? key,
  this.desc,
  this.title,
  this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    title: Text(
      title!,
      style: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.black,
    
      ),
    ),
    content: Text(
      desc!,
      style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.black,
        ),
    ),
    actions: [
      
      Center(
        child: ElevatedButton(
          onPressed: onTap,
          child: Text("Ok"),
          style: ElevatedButton.styleFrom(
                                       primary: Theme.of(context).appBarTheme.backgroundColor, // background
                                       onPrimary: Colors.white, 
                                      minimumSize: const Size(90, 40),
                                      maximumSize: const Size(90, 40),// foreground
                                     shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                     )
                                     ),
        ),
      ),
    ],
          
    );
  }
}