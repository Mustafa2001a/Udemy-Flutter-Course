import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_first_app/modules/bmi_result/result_screen.dart';

class BmiCalculator extends StatefulWidget {
  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  int age = 20;
  int wieght = 50;
  double hight = 120.0;
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A2550),
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Color(0xff2A2550),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState((){
                          isMale = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: isMale ? Colors.indigoAccent : Color(0xff363062),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.male,
                              size: 100.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'MALE',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState((){
                          isMale = false;
                          });
                         },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: isMale ? Color(0xff363062) : Colors.indigoAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.female,
                            size: 100.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'FEMALE',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xff363062),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'HIGHT',
                        style:
                            TextStyle(color: Colors.grey[300], fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${hight.round()}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'cm',
                            style: TextStyle(
                                color: Colors.grey[300], fontSize: 20.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Slider(
                          value: hight,
                          min: 80,
                          max: 200,
                          thumbColor: Colors.indigoAccent,
                          activeColor: Colors.indigoAccent,
                          onChanged: (value) {
                            setState((){
                              hight = value;
                            });
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xff363062),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style:
                            TextStyle(color: Colors.grey[300], fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '$age',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(heroTag: 'age-1',onPressed: (){setState((){
                                age--;
                              });},mini: true,backgroundColor: Colors.indigo, child: Icon(Icons.remove),),
                              FloatingActionButton(heroTag: 'age+1',onPressed: (){setState((){
                                age++;
                              });}, mini: true,backgroundColor: Colors.indigo,child: Icon(Icons.add),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xff363062),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Wieght',
                            style:
                            TextStyle(color: Colors.grey[300], fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '$wieght',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                heroTag: 'wieght-1',
                                onPressed: (){
                                  setState((){
                                    wieght--;
                                  });
                                },
                                mini: true,
                                backgroundColor: Colors.indigo,
                                child: Icon(Icons.remove),
                              ),
                              FloatingActionButton(
                                heroTag: 'wieght+1',
                                onPressed: (){
                                  setState((){
                                    wieght++;
                                  });
                                },
                                mini: true,
                                backgroundColor: Colors.indigo,
                                child: Icon(Icons.add),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: MaterialButton(
              onPressed: () {
                double result = wieght / pow(hight/100, 2);
                print(result.round());
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(
                  result,age,wieght,isMale
                ),));
              },
              child: Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            color: Color(0xff963960),
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
