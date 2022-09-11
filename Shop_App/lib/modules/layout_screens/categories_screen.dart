import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context, state) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCategoryItem(
                            ShopCubit.get(context).categoriesModel.data.data[index]
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(left: 20.0,top: 5.0,bottom: 5.0),
                          child: Container(width: double.infinity,color: Colors.grey[300],height: 1.0,),
                        ),
                        itemCount: ShopCubit.get(context).categoriesModel.data.data.length
                );

        },
        listener: (context, state) {

        },
    );
  }

Widget buildCategoryItem(DataModel model)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Row(
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 10.0,),
      Text('${model.name}',style: TextStyle(fontSize: 18.0),),
      Spacer(),
      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined))
    ],
  ),
);

}