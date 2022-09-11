import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/hoe_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/layout_screens/categories_screen.dart';
import 'package:shop_app/modules/layout_screens/favorites_screen.dart';
import 'package:shop_app/modules/layout_screens/home_screen.dart';
import 'package:shop_app/modules/layout_screens/settings_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(AppInitialState());

  static get(context) => BlocProvider.of<ShopCubit>(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  changeIndex(int index) {
    currentIndex = index;
    emit(BtnNavBarState());
  }

  HomeModel? homeModel;
  FavoritesModel? favoritesModel;
  Map<int?, bool?> favorits = {};

  void getHomeData({token}) {
    emit(LoadingHomeData());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorits.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorits.toString());
      emit(SuccessHomeData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeData());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);
      print(categoriesModel!.data!.data![0].image);
      emit(SuccessCategories());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCategories());
    });
  }

  changeFavorites(int productId) {
    favorits[productId] = !favorits[productId]!;
    emit(ChangeFavorites());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (changeFavoritesModel!.status == false) {
        favorits[productId] = !favorits[productId]!;
      } else {
        getFavorites();
      }
      emit(SuccessChangeFavorites(changeFavoritesModel!));
    }).catchError((error) {
      print(error.toString());
      favorits[productId] = !favorits[productId]!;
      emit(ErrorChangeFavorites());
    });
  }

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
            url: FAVORITES,
            token:token)

        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel!.status);
      emit(SuccessGetFavorites());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetFavorites());
    });
  }

  ShopLoginModel? userModel;
  void getUserData({token}) {
    emit(LoadingUserDataState());
    DioHelper.getData(
        url: PROFILE,
        token:token)
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(SuccessUserData(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUserData());
    });
  }

  void updateUserData({token,
  required String name,
  required String email,
  required String phone,
  })
  {
    emit(LoadingUpdateUserData());
    DioHelper.putData(
        url: UPDATE,
        token:token,
        data: {
          'name': name,
          'email':email,
          'phone':phone
        })
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(SuccessUpdateUserData(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateUserData());
    });
  }





}
