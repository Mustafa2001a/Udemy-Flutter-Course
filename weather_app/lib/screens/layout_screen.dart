import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/components.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/cubit/weather_state.dart';
import 'package:weather_app/model/weather_model.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<WeatherCubit, WeatherStates>(

      listener: (context, state) {

      },
      builder: (context, state) {
        WeatherModel? weatherModel = WeatherCubit.get(context)!.weatherModel;
        return Scaffold(
              appBar: AppBar(
                backgroundColor:WeatherCubit.
                get(context).changeAppBarColor(weatherModel!.current!.condition!.text) ,
                title: Text('${weatherModel.location!.country}'),
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: WeatherCubit.
                  get(context).changeBackgroundColor(weatherModel.current!.condition!.text),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      '${weatherModel.location!.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jannah',
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      'Updated at : ${separateText(weatherModel.current!.lastUpdated)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Jannah',
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '  ${(weatherModel.current!.tempC).round()}°',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Jannah',
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        Image(
                          image: NetworkImage(
                            'http:${weatherModel.current!.condition!.icon}',
                          ),
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '${weatherModel.current!.condition!.text}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jannah',
                      ),
                    ),
                    SizedBox(height: 20,),
                  Spacer(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      color: Colors.transparent,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Row(
                          children: [
                            forecastByHourItem(weatherModel,1),
                            forecastByHourItem(weatherModel,4),
                            forecastByHourItem(weatherModel,7),
                            forecastByHourItem(weatherModel,10),
                            forecastByHourItem(weatherModel,13),
                            forecastByHourItem(weatherModel,16),
                            forecastByHourItem(weatherModel,19),
                            forecastByHourItem(weatherModel,22),
                          ],
                        ),
                      ),
                    ),
                  ),
                    Spacer()
                  ],
                ),
              ),
          );
      },
    );
  }

  String separateText(String? text){
    return text!.substring(11);
  }


}
