import 'package:calculator_app/components.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Calculator extends StatefulWidget {

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String operation = '';
  String result = '0';

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        backgroundColor: HexColor('541690'),
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body:Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 20.0,bottom: 20.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(15.0)
                        ),
                     child: Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Text(operation,style: TextStyle(color: Colors.grey[700],fontSize: 28.0,),maxLines: 3,overflow: TextOverflow.ellipsis),
                           SizedBox(
                             height: 20.0,
                           ),
                           Text('$result',style: TextStyle(color: Colors.black,fontSize: 40.0,),maxLines: 1,overflow: TextOverflow.ellipsis),
                         ],
                       ),
                  ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            defaultBotton(
                              text: 'C',
                              bColor: Colors.red,
                              tColor: Colors.white,
                              onPress: () {
                                setState(() {
                                  result = '0';
                                  operation ='';
                                });
                              },
                            ),
                            defaultBotton(
                              text: 'del',
                              bColor: Colors.green,
                              tColor: Colors.white,
                              onPress: () {
                                setState(() {
                                  try{
                                    operation = operation.substring(0,operation.length-1);
                                  }catch(error){
                                    print(error.toString());
                                  }

                                });
                              },
                            ),
                            defaultBotton(
                              text: '%',
                              bColor: Colors.deepPurple,
                              tColor: Colors.white,
                              onPress: () {
                                setState(() {
                                });
                              },
                            ),
                            defaultBotton(
                              text: '÷',
                              bColor: Colors.deepPurple,
                              tColor: Colors.white,
                              onPress: () {
                                setState(() {
                                  operation += '÷';
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            defaultBotton(
                              text: '7',
                              onPress: () {
                                setState(() {
                                  operation += '7';
                                });
                              },
                            ),
                            defaultBotton(
                              text: '8',
                              onPress: () {
                                setState(() {
                                  operation += '8';
                                });
                              },
                            ),
                            defaultBotton(
                              text: '9',
                              onPress: () {
                                setState(() {
                                  operation += '9';
                                });
                              },
                            ),
                            defaultBotton(
                              text: 'x',
                              bColor: Colors.deepPurple,
                              tColor: Colors.white,
                              onPress: () {
                                setState(() {
                                  operation += 'x';
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            defaultBotton(
                              text: '4',
                              onPress: () {
                                setState(() {
                                  operation += '4';
                                });
                              },
                            ),
                            defaultBotton(
                              text: '5',
                              onPress: () {
                                setState(() {
                                  operation += '5';
                                });
                              },
                            ),
                            defaultBotton(
                              text: '6',
                              onPress: () {
                                setState(() {
                                  operation += '6';
                                });
                              },
                            ),
                            defaultBotton(
                              text: '-',
                              bColor: Colors.deepPurple,
                              tColor: Colors.white,
                              onPress: () {
                                setState(() {
                                  operation += '-';
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            defaultBotton(
                              text: '1',
                              onPress: () {
                                setState(() {
                                  operation += '1';
                                });
                              },
                            ),
                            defaultBotton(
                              text: '2',
                              onPress: () {
                                setState(() {
                                  operation += '2';
                                });
                              },
                            ),
                            defaultBotton(
                              text: '3',
                              onPress: () {
                                setState(() {
                                  operation += '3';
                                });
                              },
                            ),
                            defaultBotton(
                              text: '+',
                              bColor: Colors.deepPurple,
                              tColor: Colors.white,
                              onPress: () {
                                setState(() {
                                  operation += '+';
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            defaultBotton(
                              text: '.',
                              onPress: () {
                                setState(() {
                                  operation += '.';
                                });
                              },
                            ),
                            defaultBotton(
                                text: '0',
                                onPress: () {
                                  setState(() {
                                    operation += '0';
                                  });
                                },
                            ),
                            defaultBotton(
                              text: 'ans',
                              onPress: () {
                                setState(() {
                                  if(result=='0' ) {
                                    operation = ' ';
                                  }else {
                                    operation = ' ';
                                    operation += result;
                                  }
                                });
                              },
                            ),
                            defaultBotton(
                              text: '=',
                              bColor: Colors.deepPurple,
                              tColor: Colors.white,
                              onPress: () {
                                setState(() {

                                  });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              )
            ],
          ),


    );
  }
}
