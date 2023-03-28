import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/layout/home_layout.dart';
import 'package:my_first_app/modules/home/home_screen.dart';
import 'package:my_first_app/modules/login/login_screen.dart';
import 'package:my_first_app/modules/massenger/massanger_screen.dart';
import 'package:my_first_app/modules/users/users_screen.dart';
import 'package:my_first_app/shared/bloc_observer.dart';
import 'modules/bmi/bmi_calculator.dart';
import 'modules/counter/counter_screen.dart';
import 'modules/bmi_result/result_screen.dart';
import 'modules/counter/cubit/cubit.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
