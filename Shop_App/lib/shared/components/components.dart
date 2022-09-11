import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

Future NavigatTo(context, Widget widget) =>
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget)
    );

Future ReplaceNavigat(context, Widget widget) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget)
    );


Widget defaultButton({
    double width_ = double.infinity,
    Color bacground = Colors.indigoAccent,
    double radius = 7,
    required Function() function,
    required String text,
}) => Container(
    width: width_,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: bacground,
    ),
    child: MaterialButton(
        onPressed: function,
        child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Jannah',
                fontSize: 17.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
            ),
        ),
    ),
);

//------------------------------------------------------------------------------
Widget defaultFormField({
    required TextEditingController controller,
    TextInputType? input_type,
    String lb_text = '',
    IconData prefix = Icons.title,
    void Function()? onTapFunction,
    String? Function(String?)? validFuction,
    Function(dynamic)? onSubmitted,
    Function(String)? onChngFunc,
}) => TextFormField(
    controller: controller,
    keyboardType: input_type,
    onTap: onTapFunction,
    onChanged: onChngFunc,
    onFieldSubmitted: onSubmitted,
    decoration: InputDecoration(
//hintText: 'Email Address',
        labelText: lb_text,
        labelStyle: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.grey[800]
        ),
        enabledBorder: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0)
        ),

    ),
    validator: validFuction,
// (value){
// if(value!.isEmpty) {
// return 'Email address must not be empty';
// }else
// {
// return null;
// }
// },
);

//-------------------------------------------------------------------------------

void flutterToast({
    required String? text,
    required ToastStates state,
}) => Fluttertoast.showToast(
msg: text!,
toastLength: Toast.LENGTH_SHORT,
gravity: ToastGravity.CENTER,
timeInSecForIosWeb: 1,
backgroundColor: chooseColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates{SUCCESS, ERROR, WARNING}

Color chooseColor(ToastStates state)
{
    Color? color;
    switch(state)
    {
        case ToastStates.SUCCESS:
            color = Colors.green;
            break;
        case ToastStates.ERROR:
            color = Colors.red;
            break;
        case ToastStates.WARNING:
            color = Colors.amber;
            break;
    }
    return color;
}

//------------------------------------------------------------------------------
Widget signOut(context) =>TextButton(
onPressed: ()async {
    await CacheHelper.removeData(key:'token').then((value) {
        token = '';
        ReplaceNavigat(context,LoginScreen());
    }

     );
},
child: Text('LOGOUT',style: TextStyle(
      fontFamily: 'Jannah',
      fontSize: 17.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
  ),
  ),
);

String? token ='';

    //---------------------------------------------------------------------------


Widget buildFavList(model, context,{bool? isSearch = true}) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
        height: 120.0,
        child: Row(
            children: [
                Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                        Image(
                            image: NetworkImage('${model.image}'),
                            width: 120.0,
                            height: 120.0,
                        ),
                        if (model.discount != 0)
                            Container(
                                color: Colors.red,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                ),
                                child: Text(
                                    'DISCOUNT',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        color: Colors.white,
                                    ),
                                ),
                            ),
                    ],
                ),
                SizedBox(
                    width: 20.0,
                ),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                '${model.name}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    height: 1.3,
                                ),
                            ),
                            Spacer(),
                            Row(
                                children: [
                                    Text(
                                        model.price.toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.indigoAccent,
                                        ),
                                    ),
                                    SizedBox(
                                        width: 5.0,
                                    ),
                                    if (model.discount != 0)
                                      if(isSearch == true)
                                        Text(
                                            model.oldPrice.toString(),
                                            style: TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.grey,
                                                decoration: TextDecoration.lineThrough,
                                            ),
                                        ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                            ShopCubit.get(context)
                                                .changeFavorites(model.id);
                                        },
                                        icon: CircleAvatar(
                                            radius: 15.0,
                                            backgroundColor: ShopCubit.get(context)!
                                                .favorits![model.id]
                                                ? Colors.indigoAccent
                                                : Colors.grey,
                                            child: Icon(
                                                Icons.favorite_border,
                                                size: 14.0,
                                                color: Colors.white,
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ],
        ),
    ),
);