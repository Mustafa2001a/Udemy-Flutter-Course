import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/hoe_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is SuccessChangeFavorites){
          if(state.changeFavoritesModel!.status == false){
            flutterToast(text: state.changeFavoritesModel!.message , state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) =>
              productsBuilder(model: ShopCubit.get(context).homeModel, cmodel: ShopCubit.get(context).categoriesModel,context: context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );

  }

  Widget productsBuilder({required HomeModel model,required CategoriesModel cmodel,required BuildContext context}) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                height: 250.0,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                autoPlayInterval: Duration(seconds: 3),
                reverse: false,
                enableInfiniteScroll: true,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                'Categories',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w400,
              ),),
            ),
                Container(
                  height: 110.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoriesItem(model: cmodel.data!.data![index] ),
                    separatorBuilder: (context, index) => SizedBox(),
                    itemCount: cmodel.data!.data!.length,
                ),
              ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.53,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      buildGridProduct(model: model.data!.products[index],context: context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem({DataModel? model}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),

      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(image: NetworkImage('${model!.image}'),
            width: 110.0,
            height: 110.0,
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.8),
            child: Text(
              '${model.name}',
              style: TextStyle(color: Colors.white,),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),

            width: 110.0,
          ),
        ],
      ),
    ),
  );


  Widget buildGridProduct({required ProductModel model,required BuildContext context}) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  height: 200.0,
                ),
                if(model.discount != 0)
                  Container(
                  color: Colors.red,
                  child: Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 10.0),)
                  ,padding: EdgeInsets.symmetric(horizontal: 5.0),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style:
                        TextStyle(overflow: TextOverflow.ellipsis, height: 1.3),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}\$',
                        style: TextStyle(
                          height: 1.6,
                          color: Colors.indigoAccent,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(model.discount != 0)
                        Text(
                          '${model.oldPrice}\$',
                          style: TextStyle(
                            height: 1.6,
                            color: Colors.grey,
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough
                          ),),
                      Spacer(),
                      IconButton(
                          onPressed: (){
                            ShopCubit.get(context).changeFavorites(model.id);
                            print(model.id);
                          },
                          icon: CircleAvatar(child: Icon(Icons.favorite_border,
                            size: 20.0,
                            color: Colors.white,
                          ),
                            radius: 16.0,
                            backgroundColor: ShopCubit.get(context).favorits[model.id]? Colors.indigoAccent: Colors.grey,
                          ),
                      ),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

}


