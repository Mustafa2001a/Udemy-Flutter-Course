import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout_screens/search/search_cubit.dart';
import 'package:shop_app/modules/layout_screens/search/search_state.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    var formKey =  GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0.6,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultFormField(
                          input_type: TextInputType.text,
                          controller: searchController,
                          lb_text: 'Search',
                          prefix: Icons.search,
                          validFuction: (value) {
                            if(value!.isEmpty)
                              return 'Search Text Should not be empty';

                            return null;
                          },
                          onSubmitted: (text){
                            SearchCubit.get(context).getSearch(text);
                          }
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              buildFavList(SearchCubit.get(context).searchModel.data.data[index], context,isSearch: false),
                          separatorBuilder: (context, index) =>  Container(
                              width: double.infinity,
                              color: Colors.grey[300],
                              height: 1.0,
                            ),
                          itemCount: SearchCubit.get(context).searchModel.data.data.length,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}