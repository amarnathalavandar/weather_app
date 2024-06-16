import 'dart:ui';

import 'package:flutter/material.dart';

class VerticalContainer extends StatelessWidget {
  const VerticalContainer( {
    super.key,
    required this.celsiusText,
    required this.imageURL,
    this.day='Monday',
    this.dateString='07-06-2024',
    this.weatherDesc='Slightly Rain',
    this.startTime='12:00'

  });

  final String celsiusText;
  final String imageURL;
  final String day;
  final String dateString;
  final String weatherDesc;
  final String startTime;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Transparent white color
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Image.asset(imageURL,width: 40,height: 50,),
                      const SizedBox(width: 8.0,),
                      Text(celsiusText),
                      const SizedBox(width: 8.0,),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Text(weatherDesc.toUpperCase(),style: const TextStyle(
                    fontSize: 10,fontWeight: FontWeight.bold,
                color: Colors.black54,
                ),),
                const SizedBox(height: 8,),
                Center(child: Text(startTime,style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,))),
                const SizedBox(height: 8,),
                Text(day.substring(0,3),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,)),
                const SizedBox(height: 4,),
                Text(dateString,style: const TextStyle(
                  fontSize: 10,fontWeight: FontWeight.bold,
                  color: Colors.black54,))
                //Divider(height: 2,color: Colors.white24,indent: 20,endIndent: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
