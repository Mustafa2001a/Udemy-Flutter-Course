import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultBotton({
  required String text,
  required void Function()? onPress,
  Color? bColor = Colors.white,
  Color? tColor = Colors.deepPurple,

}) => Padding(
padding: const EdgeInsets.all(5.0),
child: Container(
child: MaterialButton(
onPressed: onPress,
child: Text(text,style: TextStyle(color: tColor,fontSize: 28.0,),),
),
decoration: BoxDecoration(
color: bColor,
borderRadius: BorderRadiusDirectional.circular(10.0),
),
width: 90,
height: 82,
),
);