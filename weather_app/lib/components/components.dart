import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

Widget defaultSearchField({required Function(String)? onSubmit}) => Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        decoration: BoxDecoration(
          border: const GradientBoxBorder(
            gradient:
            LinearGradient(colors: [Colors.lightBlueAccent, Colors.amberAccent]),
            width: 6
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: TextField(
            style: TextStyle(color: Colors.indigoAccent[200], fontSize: 18),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.indigoAccent[200],
              ),
              hintText: 'Search for a Location ...',
              hintStyle: TextStyle(color: Colors.indigoAccent[200], fontSize: 18),
            ),
            onSubmitted: onSubmit,
          ),
        ),
      ),
    );

Future<dynamic> defaultNavigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
Widget loadingScreen() => Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );




String separateText(String? text){
  return text!.substring(11);
}

Widget forecastByHourItem(weatherModel,i)=>Padding(
  padding: const EdgeInsets.all(10),
  child:   Column(

    children: [

      Row(
        children: [
          Text('${separateText(weatherModel.forecast!.forecastday![0].hour![i].time)}'
          ,style: TextStyle(
              fontFamily: 'Jannah',
              fontSize: 16.0,
              color: Colors.black87
            ),
          ),
        ],
      ),

      Image(

        image: NetworkImage(

          'http:${weatherModel.forecast!.forecastday![0].hour![i].condition!.icon}',

        ),

        fit: BoxFit.cover,

        height: 80,

        width: 80,
      ),
      Text('${weatherModel.forecast!.forecastday![0].hour![i]!.tempC}°'
        ,style: TextStyle(
            fontFamily: 'Jannah',
            fontSize: 16.0,
          color: Colors.black87
        ),
      ),

      Text('${weatherModel.forecast!.forecastday![0].hour![i].condition!.text}',
      style: TextStyle(
        fontFamily: 'Jannah',
        fontSize: 15,
        color: Colors.black87
      ),
      ),

    ],

  ),
);