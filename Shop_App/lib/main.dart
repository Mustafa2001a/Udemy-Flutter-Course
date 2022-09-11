
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/layout_screens/settings_screen.dart';
import 'package:shop_app/modules/login/cubit_login.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'bloc_observer.dart';
int? isViewed;
String? isToken;
Widget? startWidget;
void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

    bool? isDark = CacheHelper.getData(key: 'isDark');
    //bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
    isViewed = CacheHelper.sharedPreferences!.getInt('onBoarding');
    isToken = CacheHelper.sharedPreferences!.getString('token');
    token = isToken;
    if(isViewed != null){
      if(isToken != null) startWidget = ShopLayout();
      else startWidget = LoginScreen();

    }else{
      print(isToken);
        startWidget = OnBoardingScreen();
    }

    // ignore: deprecated_member_use
    BlocOverrides.runZoned(
          () => runApp(
              MyApp(isDark)
          ),
      blocObserver: MyBlocObserver(),
    );




}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData(token: token)..getCategories()..getFavorites()..getUserData(token: token),),
        BlocProvider(create: (context) => LoginCubit(),),
    ],
      child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: startWidget ?? LoginScreen(),  //isViewed !=0 ? OnBoardingScreen() : LoginScreen() ,
        theme: lightTheme
        //   ThemeData(
        //   appBarTheme: AppBarTheme(
        //     color: Colors.indigo,
        //     systemOverlayStyle: SystemUiOverlayStyle(
        //       statusBarColor: Colors.indigo[50],
        //       statusBarIconBrightness: Brightness.dark
        //     )
        //   ),
        //   textTheme: newTheme,
        //   primarySwatch: Colors.indigo,
        //   floatingActionButtonTheme: FloatingActionButtonThemeData(
        //     backgroundColor: Colors.indigo,
        //   ),
        // ),

            ),
    );


  }
}



