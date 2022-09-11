import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit, ShopStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         ShopCubit cubit = ShopCubit.get(context);
//         return ConditionalBuilder(
//           condition: state is! ShopLoadingGetFavoritesState,
//           builder: (context) => ListView.separated(
//             itemBuilder: (context, index) => buildFavItem(
//                 model: cubit.favoritesModel!.data!.data![index],
//                 context: context),
//             separatorBuilder: (context, index) => Padding(
//               padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
//               child: Container(
//                 width: double.infinity,
//                 color: Colors.grey[300],
//                 height: 1.0,
//               ),
//             ),
//             itemCount: cubit.favoritesModel!.data!.data!.length,
//           ),
//           fallback: (context) => Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }

//   Widget buildFavItem(
//           {required FavoritesData model, required BuildContext context}) =>
//       Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           height: 120.0,
//           child: Row(
//             children: [
//               Stack(
//                 alignment: AlignmentDirectional.bottomStart,
//                 children: [
//                   Image(
//                     image: NetworkImage('${model.product!.image}'),
//                     width: 120,
//                     height: 120,
//                     fit: BoxFit.cover,
//                   ),
//                   if (model.product!.discount != 0)
//                     Container(
//                       color: Colors.red,
//                       child: Text(
//                         'DISCOUNT',
//                         style: TextStyle(color: Colors.white, fontSize: 10.0),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 5.0),
//                     ),
//                 ],
//               ),
//               SizedBox(
//                 width: 10.0,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${model.product!.name}',
//                       style: TextStyle(
//                           overflow: TextOverflow.ellipsis, height: 1.3),
//                       maxLines: 2,
//                     ),
//                     Spacer(),
//                     Row(
//                       children: [
//                         Text(
//                           '${model.product!.price}\$',
//                           style: TextStyle(
//                             height: 1.6,
//                             color: Colors.indigoAccent,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5.0,
//                         ),
//                         if (model.product!.discount != 0)
//                           Text(
//                             //'${model.oldPrice}\$',
//                             'MOdelOld',
//                             style: TextStyle(
//                                 height: 1.6,
//                                 color: Colors.grey,
//                                 fontSize: 12.0,
//                                 decoration: TextDecoration.lineThrough),
//                           ),
//                         Spacer(),
//                         IconButton(
//                           onPressed: () {
//                             ShopCubit.get(context)
//                                 .changeFavorites(model.product!.id);
//                           },
//                           icon: CircleAvatar(
//                             child: Icon(
//                               Icons.favorite_border,
//                               size: 20.0,
//                               color: Colors.white,
//                             ),
//                             radius: 16.0,
//                             backgroundColor: ShopCubit.get(context)
//                                     .favorits[model.product!.id]
//                                 ? Colors.indigoAccent
//                                 : Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
// }
class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildFavList(cubit.favoritesModel!.data!.data![index].product, context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
              child: Container(
                width: double.infinity,
                color: Colors.grey[300],
                height: 1.0,
              ),
            ),
            itemCount: cubit.favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
