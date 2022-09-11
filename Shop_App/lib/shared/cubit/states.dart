import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class AppInitialState extends ShopStates {}

class BtnNavBarState extends ShopStates {}

class LoadingHomeData extends ShopStates {}

class SuccessHomeData extends ShopStates {}

class ErrorHomeData extends ShopStates {}

class SuccessCategories extends ShopStates {}

class ErrorCategories extends ShopStates {}

class ChangeFavorites extends ShopStates {}

class SuccessChangeFavorites extends ShopStates {
  ChangeFavoritesModel? changeFavoritesModel;

  SuccessChangeFavorites(this.changeFavoritesModel);
}

class ErrorChangeFavorites extends ShopStates {}

class SuccessGetFavorites extends ShopStates {}

class ErrorGetFavorites extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class SuccessUserData extends ShopStates {
  final ShopLoginModel loginModel;

  SuccessUserData(this.loginModel);
}

class ErrorUserData extends ShopStates {}

class LoadingUserDataState extends ShopStates {}

class SuccessUpdateUserData extends ShopStates {
  final ShopLoginModel loginModel;

  SuccessUpdateUserData(this.loginModel);
}

class ErrorUpdateUserData extends ShopStates {}

class LoadingUpdateUserData extends ShopStates {}




