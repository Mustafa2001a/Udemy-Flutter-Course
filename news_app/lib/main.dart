import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/bloc_observer.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/mode_cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/networks/local/cache_helper.dart';
import 'package:news_app/shared/networks/remote/dio_helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  BlocOverrides.runZoned(
        () => runApp(MyApp(isDark)),
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
        BlocProvider(
          create: (BuildContext context) => ModeCubit()..ChangeMode(
              fromShared: isDark ),),
        BlocProvider(
        create: (context) => AppCubit()..getBusiness(),
        ),
    ],
      child: BlocConsumer<ModeCubit,AppStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return MaterialApp(
              home: NewsLayout(),
              darkTheme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: HexColor('333739'),
                  appBarTheme: AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      iconTheme: IconThemeData(
                          color: Colors.white
                      ),
                      titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0
                      ),
                      backgroundColor: Colors.black12,
                      elevation: 20.0
                  ),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),

                  ),

                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    backgroundColor: HexColor('333739'),
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange,
                  )
              ),
              themeMode: ModeCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarIconBrightness: Brightness.light,
                      ),
                      iconTheme: IconThemeData(
                          color: Colors.black
                      ),
                      titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22.0
                      ),
                      backgroundColor: Colors.white,
                      elevation: 2.0
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      selectedItemColor: Colors.deepOrange
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange,
                  )
              ),
              debugShowCheckedModeBanner: false,
            );
          },

        ),
    );
  }
}
