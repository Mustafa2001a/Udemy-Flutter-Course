import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/components.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/cubit/weather_state.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/screens/layout_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {


        return Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/base_background_edit_.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.transparent,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Spacer(),
                    Spacer(),
                    const Text(
                      'Weather',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontFamily: 'Jannah',
                      ),
                    ),
                    SizedBox(height: 70,),
                    Spacer(),
                    ConditionalBuilder(
                      condition: state is WeatherGetApiLoadingState,
                      builder:(context) => Center(child: CircularProgressIndicator(),),
                      fallback: (context) => defaultSearchField(onSubmit: (input) async{
                        if (input.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: const Text('Please enter a location!',),
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.indigo,
                            ),
                          );
                        }else {
                          WeatherCubit cubit = WeatherCubit.get(context);
                          await cubit.getWeatherModel(input,context);
                          defaultNavigateTo(context, LayoutScreen());
                        }
                      }),

                    ),
                    Spacer(),

                  ],
                ),
              ],
            ));
      },
    );
  }
}
