import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_state.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';




class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitial());

  static get(context) => BlocProvider.of<WeatherCubit>(context);

  String apiKey = '92a7f8b46dbe46e983b162631220510';
  String baseUrl = 'https://api.weatherapi.com/v1';
  String cityName='';


  WeatherModel? weatherModel;
  Future<WeatherModel?> getWeatherModel(cityName_,context) async {

    cityName = cityName_;
    // في هدول السطرين بجيب ال api عندي وبرد عليا بـresponse
    var url =
    Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName_');

    emit(WeatherGetApiLoadingState());

    http.Response response = await http.get(url);
    // هلقيت بحول الresponse لjson عشان يسهل التعامل معاه، يعني كإنه برتبها في model باستخدام jsonDecode
    Map<String, dynamic> data = jsonDecode(response.body);

    weatherModel = WeatherModel.fromJson(data);

    emit(WeatherGetApiSuccessState());
    return weatherModel;
  }
  Color changeAppBarColor(String text){
    if(text == "Clear"){
      return Colors.blue.shade400;
    }
    else if(text == "Partly cloudy"){
      return Colors.blueGrey.shade500;
    }
    else if(text == "Sunny"){
      return Colors.orangeAccent.shade400;
    }else{
      return Colors.grey.shade700;
  }
  }


  Gradient? changeBackgroundColor(String text){
    if(text == "Clear"){
      return LinearGradient(
        colors: [Colors.blue.shade400,Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    else if(text == "Partly cloudy"){
      return LinearGradient(
        colors: [Colors.blueGrey.shade500,Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    else if(text == "Sunny"){
      return LinearGradient(
        colors: [Colors.orangeAccent.shade400,Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }else{
      return LinearGradient(
        colors: [Colors.grey.shade700,Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

  }

}