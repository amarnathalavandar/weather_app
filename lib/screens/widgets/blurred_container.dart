import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredContainer extends StatelessWidget {
   BlurredContainer( {super.key, this.getWeatherIcon,  this.celsiusText,  this.weatherMain,  this.weatherDate});

   Widget? getWeatherIcon=null;
   Text? celsiusText=null;
   Text? weatherMain=null;
   Text? weatherDate=null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 220,
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
              children: [
                Row(
                  children: [
                    getWeatherIcon!,
                    const SizedBox(width: 8.0,),
                    celsiusText!,
                  ],
                ),
                Divider(height: 2,color: Colors.white24,indent: 20,endIndent: 20,),
                const SizedBox(height: 4.0,),
                weatherMain!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    weatherDate!
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}