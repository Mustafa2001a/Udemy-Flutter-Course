import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterState>
{
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of<CounterCubit>(context);

  int counter_ = 1;

  void minusCounter()
  {
    counter_--;
    emit(CounterMinusState(counter_));
  }
  void plusCounter()
  {
    counter_++;
    emit(CounterPlusState(counter_));
  }

}