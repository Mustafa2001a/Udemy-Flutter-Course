import 'package:flutter/material.dart';
import 'package:my_first_app/shared/cubit/todo_cubit.dart';

Widget defaultButton({
  double width_ = double.infinity,
  Color bacground = Colors.blue,
  double radius = 0,
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
        fontSize: 17.0,
        color: Colors.white,
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
   Function(String)? onSubmitted,
}) => TextFormField(
controller: controller,
keyboardType: input_type,
onTap: onTapFunction,
onFieldSubmitted: onSubmitted,
decoration: InputDecoration(
//hintText: 'Email Address',
labelText: lb_text,
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


//------------------------------------------------------------------------------

Widget tasks(Map model,context) =>
Dismissible(
  key: Key(model['id'].toString()),

  child:   Padding(
  
      padding: const EdgeInsets.all(20.0),
  
      child: Row(
  
          children: [
  
            CircleAvatar(
  
  
  
              radius: 40.0,
  
  
  
              child: Text('${model['time']}'),
  
  
  
            ),
  
            SizedBox(
  
  
  
              width: 15.0,
  
  
  
            ),
  
            Expanded(
  
  
  
              child: Column(
  
                crossAxisAlignment: CrossAxisAlignment.start,
  
                mainAxisSize: MainAxisSize.min,
  
  
  
                children: [
  
  
  
                  Text(
  
  
  
                    '${model['title']}',
  
  
  
                    style: TextStyle(
  
  
  
                      fontWeight: FontWeight.bold,
  
  
  
                      fontSize: 22.0,
  
  
  
                    ),
  
  
  
                  ),
  
  
  
                  Text(
  
  
  
                    '${model['date']}',
  
  
  
                    style: TextStyle(
  
  
  
                        color: Colors.grey[600],
  
  
  
                        fontSize: 15.0
  
  
  
                    ),
  
  
  
                  ),
  
  
  
                ],
  
  
  
              ),
  
  
  
            ),
  
            SizedBox(
  
  
  
              width: 10.0,
  
  
  
            ),
  
            IconButton(
  
  
  
                onPressed: (){
  
                    AppCubit.get(context).UpdateData(status: 'done', id: model['id']);
  
  
  
                },
  
  
  
                icon: Icon(
  
  
  
                  Icons.check_box,
  
  
  
                color: Colors.green,
  
  
  
                ),
  
  
  
            ),
  
            IconButton(
  
  
  
                onPressed: (){
  
                  AppCubit.get(context).UpdateData(status: 'archived', id: model['id']);
  
  
  
                },
  
  
  
                icon: Icon(
  
  
  
                  Icons.archive,
  
  
  
                color: Colors.black45,
  
  
  
                ),
  
  
  
            ),
  
          ],
  
  
  
      ),
  
  
  
    ),

  onDismissed: (direction) {
    AppCubit.get(context).DeleteDB(id: model['id']);
  },
);




