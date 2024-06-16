import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screens/widgets/blurred_container.dart';
import 'package:weather_app/screens/widgets/vertical_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherSuccess) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(30, -0.2),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.yellow),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-30, -0.2),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.lightBlue),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(1, -1.1),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurpleAccent),
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 100.0),
                        child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text('${state.weather.areaName}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                    ))
                              ],
                            ),
                            const Text(
                              'Good Morning',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            //getWeatherIcon(state.weather.weatherConditionCode),
                            Center(
                                child: BlurredContainer(celsiusText:Text(
                                  '${state.weather.temperature!.celsius?.roundToDouble()}°C',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 55),
                                ),
                                    getWeatherIcon: Image.asset(getWeatherIcon(
                                        state.weather.weatherConditionCode),height: 140,width: 120),
                                  weatherMain: Text(
                                    state.weather.weatherMain!.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20),
                                  ), weatherDate: Text(
                                    DateFormat('EEEE MM-dd-yy -')
                                        .add_jm()
                                        .format(state.weather.date!),
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),)
                            ),
                            const   SizedBox(
                              height: 30,
                            ),
                            Text('Every 3 Hrs - Forecast',style: Theme.of(context).textTheme.titleMedium,),
                            const   SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              height: 160,
                              child: ListView.separated
                                (
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                return VerticalContainer(
                                  imageURL:getWeatherIcon(
                                      state.weatherList[index].weatherConditionCode),
                                   celsiusText:
                                     '${state.weatherList[index].temperature!.celsius?.roundToDouble()}°C',
                                    weatherDesc:state.weatherList[index].weatherDescription.toString(),
                                    day:DateFormat('EEEE')
                                        .format(state.weatherList[index].date!),
                                  dateString:DateFormat('MM-dd-yy').format(state.weatherList[index].date!),
                                  startTime:getStartEndTime(state.weatherList[index].date!),


                                );

                              },
                                  separatorBuilder: (context,index) => const SizedBox(width:10),
                                  itemCount: state.weatherList.length
                              )
                            ),
                            const SizedBox(height: 30, ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/11.png',
                                      scale: 8,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunrise',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunrise!),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/12.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunset',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunset!),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child:
                                  Divider(color: Colors.grey.withOpacity(0.5)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/13.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Max',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${state.weather.tempMax!.celsius!.roundToDouble()}',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/14.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Min',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${state.weather.tempMin!.celsius!.roundToDouble()}',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  getStartEndTime(DateTime? date)
  {
    DateTime endDate = date!.add(Duration(hours: 3));

    String formattedStartTime = DateFormat('HH:mm').format(date!);
    String formattedEndTime = DateFormat('HH:mm').format(endDate);

    String displayString = '$formattedStartTime - $formattedEndTime Hrs';
    print (displayString);
    return displayString;

  }
  getWeatherIcon(int? weatherConditionCode) {
    print(weatherConditionCode);
    switch (weatherConditionCode!) {
      case >= 200 && < 300:
        return 'assets/images/1.png';
      case >= 300 && < 400:
          return 'assets/images/2.png';
      case >= 500 && < 600:
        return 'assets/images/3.png';
      case >= 600 && < 700:
          return 'assets/images/4.png';
      case >= 700 && < 800:
    return 'assets/images/5.png';
      case == 800:
        return 'assets/images/6.png';
      case > 800 && <= 804:
    return 'assets/images/7.png';
      default:
    return'assets/images/7.png' ;
    }
  }
}
