import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget {
  //Re_useable App bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left:15.0,),
          child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back, color: Colors.grey)),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Medica",
            style: GoogleFonts.poppins(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(width: 5,),
            Text("Reminder",
            style: GoogleFonts.poppins(
              color: Colors.blue.shade700
            ),),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20.0),
            child: IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.search, color: Colors.grey,)),
          )
        ],
      ),
    );
  }
}