import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/mode_cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModeCubit,AppStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var searchController = TextEditingController();
        var list = AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                    controller: searchController,
                    prefix: Icons.search,
                    lb_text: 'Search',
                  validFuction:(value) {
                    if(value!.isEmpty){
                      return 'Search Feild must not be empty !';
                    }
                    return null;
                  },
                  onChange: (value) {

                    AppCubit.get(context).getSearch(value);
                  },


                ),
                Expanded(
                  child: articleBuilder(list),
                ),
              ],
            ),
          ),
        );
      },
      
    );
  }
}
