import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../data/my_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try{
        WeatherFactory weatherFactory = WeatherFactory(API_KEY,language: Language.ENGLISH);

        Weather weather = await weatherFactory.currentWeatherByLocation(
            event.position.latitude, event.position.longitude
        );
        // Await the Future to get the list of Weather
        List<Weather> weatherList =
        await weatherFactory.fiveDayForecastByLocation(event.position.latitude, event.position.longitude);

        // Process the weatherList
        for (var weather in weatherList) {
          print('AMARNATH');
          print(weather.tempMax); // Replace with your actual processing logic
        }

        emit(WeatherSuccess(weather,weatherList));
      }catch(e){
        emit(WeatherFailure());
      }
    });
  }
}
