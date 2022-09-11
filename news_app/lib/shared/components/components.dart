import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view_screen.dart';

Widget buidNewsItem(articles,context) => InkWell(
  onTap: () {
    Navigator.push(context, MaterialPageRoute(builder:(context) => WebViewScreen(articles['url']),));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Container(

      child: Row(

        children: [

          Container(

            height: 120,

            width: 120,

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0),

              image: DecorationImage(

                image: NetworkImage('${articles['urlToImage']}'),

                fit: BoxFit.cover,

              ),

            ),

          ),

          SizedBox(

            width: 15.0,

          ),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,

              children: [

                Text('${articles['title']}',

                  style: Theme.of(context).textTheme.bodyText1,

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                ),

                SizedBox(

                  height: 15,

                ),

                Text('${articles['publishedAt']}',style: TextStyle(

                  fontSize: 13.0,

                  fontWeight: FontWeight.w600,

                  color: Colors.grey,

                ),

                ),

              ],

            ),

          ),



        ],

      ),

    ),

  ),
);


Widget defaultFormField({
  required TextEditingController controller,
  TextInputType? input_type,
  String lb_text = '',
  IconData prefix = Icons.title,
  void Function()? onTapFunction,
  void Function(String)? onChange,
  String? Function(String?)? validFuction,
  Function(String)? onSubmitted,
}) => TextFormField(
  controller: controller,
  keyboardType: input_type,
  onTap: onTapFunction,
  onChanged: onChange,
  style: TextStyle(color: Colors.grey),
  onFieldSubmitted: onSubmitted,
  decoration: InputDecoration(
//hintText: 'Email Address',
    labelText: lb_text,
    labelStyle: TextStyle(color: Colors.grey[600]),
    prefixIcon: Icon(prefix),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.0),
      borderSide: BorderSide(color: Colors.grey,width: 2.0,),
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),

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


Widget articleBuilder(list) => ConditionalBuilder(
  condition: list.length > 0  ,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return buidNewsItem(list[index],context);
      },
      separatorBuilder:(context, index) =>  Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Container(
          height: 1.0,
          color: Colors.grey[300],
          width: double.infinity,
        ),
      ),
      itemCount: 10),
  fallback: (context) => Center(child: CircularProgressIndicator()),
);


