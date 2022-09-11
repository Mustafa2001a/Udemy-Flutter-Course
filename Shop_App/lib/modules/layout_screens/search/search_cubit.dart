import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/layout_screens/search/search_cubit.dart';
import 'package:shop_app/modules/layout_screens/search/search_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(): super(SearchInitialState());

  static get(context) => BlocProvider.of<SearchCubit>(context);

  SearchModel? searchModel;
  void getSearch(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text
      },

    ).then(
        (value) {
          searchModel = SearchModel.fromJson(value.data);
          emit(SearchSuccessState());
        }
    ).catchError((error) {
      print('!! Erro: ${error.toString()}');
      emit(SearchErrorState());
    }
    );
  }


}