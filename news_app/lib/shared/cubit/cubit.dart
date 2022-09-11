import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../networks/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void ChangeMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }

  int currentIndex = 0;

  List<Widget> screens = [BusinessScreen(),SportsScreen(),ScienceScreen()];

  List<BottomNavigationBarItem> items =
  [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),

  ];

  void changeIndex(int index)
  {
    currentIndex = index;
    if(index == 1){getSports();}
    if(index == 2){getScience();}
    emit(AppNavBarState());
  }

  List<dynamic> business= [];
  List<dynamic> sports= [];
  List<dynamic> science= [];
  List<dynamic> search= [];

  void getBusiness()
  {
    emit(AppGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      //country=us&category=business
      query:
      {
        'q':'business',
        'apiKey':'25c7d8da7c5d4f31be7da697d8e02066',
      },
    ).then(
            (value) {
              business = value.data['articles'];
              print(business[0]['title']);
              emit(AppGetBusinessSuccessState());
        }
    ).catchError((error) {
      print('!! Erro: ${error.toString()}');
      emit(AppGetBusinessErrorState());
    }
      );
    }

  void getSports()
  {
    emit(AppGetSportsLoadingState());
    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/everything',
        //country=us&category=business
        query:
        {
          'q':'sports',
          'apiKey':'25c7d8da7c5d4f31be7da697d8e02066',
        },
      ).then(
              (value) {
            sports = value.data['articles'];
            print(sports[0]['title']);
            emit(AppGetSportsSuccessState());
          }
      ).catchError((error) {
        print('!! Erro: ${error.toString()}');
        emit(AppGetSportsErrorState());
      }
      );
    }
    else
    {
      emit(AppGetSportsSuccessState());
    }


  }

  void getScience()
  {
    emit(AppGetScienceLoadingState());
    if(science.length == 0)
    {
      DioHelper.getData(
        url: 'v2/everything',
        //country=us&category=business
        query:
        {
          'q':'science',
          'apiKey':'25c7d8da7c5d4f31be7da697d8e02066',
        },
      ).then(
              (value) {
            science = value.data['articles'];
            print(science[0]['title']);
            emit(AppGetScienceSuccessState());
          }
      ).catchError((error) {
        print('!! Erro: ${error.toString()}');
        emit(AppGetScienceErrorState());
      }
      );
    }
    else
    {
      emit(AppGetScienceSuccessState());

    }

  }

  void getSearch(value)
  {
    emit(AppGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      //country=us&category=business
      query:
      {
        'q':'$value',
        'apiKey':'25c7d8da7c5d4f31be7da697d8e02066',
      },
      ).then(
              (value) {
            search = value.data['articles'];
            print(search[0]['title']);
            emit(AppGetSearchSuccessState());
          }
      ).catchError((error) {
        print('!! Erro: ${error.toString()}');
        emit(AppGetSearchErrorState());
      }
      );
  }


}