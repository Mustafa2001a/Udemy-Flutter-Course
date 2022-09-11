import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/networks/local/cache_helper.dart';

class ModeCubit extends Cubit<AppStates> {
  ModeCubit() : super(AppInitialState());

  static ModeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void ChangeMode({bool? fromShared}) {
    if (fromShared != null){
      isDark = fromShared;
      emit(AppChangeModeState());
    }else{
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }



  }
}