import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double bmi;
  final int age;
  final int weight;
  final String status;
  final bool isMale;
  ResultScreen({
      required this.bmi,
      required this.age,
    required this.weight,
    required this.status,
    required this.isMale
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text('BMI Result'),
        centerTitle: true,
        backgroundColor: Color(0xff2A2550),
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xff363062),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff963960),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Gender: ${isMale ? 'Male':'Female'}',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Weight: $weight',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Age: $age',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'BMI : ${bmi.round()}',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    Text(
                      'Status : ${status}',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
