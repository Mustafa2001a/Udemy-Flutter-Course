import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../modules/search_screen.dart';
import '../shared/cubit/mode_cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {  },
        builder: (context, state)
        {
          AppCubit cubit = AppCubit.get(context);
          ModeCubit c = ModeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [

                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                    },
                  ),
                IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: ()
                  {
                    c.ChangeMode();
                  },
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: cubit.items,
              currentIndex: cubit.currentIndex,
              onTap: ((index) => cubit.changeIndex(index)),
            ),
          );
        },

      );
  }
}
