import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout_screens/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text('Salla',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                backgroundColor: Colors.white,
                elevation: 0.0,
                actions: [
                  IconButton(
                      onPressed: (){
                        NavigatTo(context, SearchScreen());
                      },
                      icon: Icon(Icons.search)
                  ),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar:BottomNavigationBar(
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps),
                      label: 'Categories'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: 'Favorites'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings'
                  ),
                ],
              )
          );
        },
        listener: (context, state) {

        },
    );
  }
}
