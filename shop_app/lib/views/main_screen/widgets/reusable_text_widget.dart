import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const ReusableTextWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width*0.03,
      vertical: MediaQuery.of(context).size.height*0.005,
    ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(title,style:GoogleFonts.montserrat(
            fontSize: MediaQuery.of(context).size.width*0.035,
            fontWeight: FontWeight.bold,
          ),overflow: TextOverflow.ellipsis,
          ),
          ),
          Text(subtitle,style:GoogleFonts.montserrat(
            fontSize: MediaQuery.of(context).size.width*0.034,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ))
        ],
      ),
    );
  }
}
