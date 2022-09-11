import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/modules/counter/cubit/cubit.dart';
import 'package:my_first_app/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterState>(
        builder: (context, state){
          return Scaffold(
          appBar: AppBar(
            title: Text('Counter'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).minusCounter();
                    },
                    child:
                    Text(
                      'MINUS',
                      style:
                      TextStyle(
                          fontSize: 20.0
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '${CounterCubit.get(context).counter_}',
                      style:
                      TextStyle(
                          fontSize: 25.0
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        CounterCubit.get(context).plusCounter();
                      },
                      child: Text(
                        'PLUS',
                        style: TextStyle(fontSize: 20.0),)
                  ),
                ],
              ),
            ],
          ),
        );
        },
        listener:  (context, state){
              if(state is CounterMinusState)
                {
                  print('Minus ${state.counter}');
                }
              else if(state is CounterPlusState)
                {
                  print('Plus ${state.counter}');
                }
        },
      ),
    );
  }
}
