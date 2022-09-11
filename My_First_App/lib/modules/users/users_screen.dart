import 'package:flutter/material.dart';
import 'package:my_first_app/models/user/user_model.dart';


class UsersScreen extends StatelessWidget{

  List<UserModel> users = [
    UserModel(id:1,name: 'Ali', phone: '+97059465452'),
    UserModel(id:2, name: 'Menna', phone: '+23423423433'),
    UserModel(id:3, name: 'Khaled', phone: '+97429465452'),
    UserModel(id:4, name: 'Manar', phone: '+97032423242'),
    UserModel(id:1, name: 'Ali', phone: '+97059465452'),
    UserModel(id:2, name: 'Menna', phone: '+23423423433'),
    UserModel(id:3, name: 'Khaled', phone: '+97429465452'),
    UserModel(id:4, name: 'Manar', phone: '+97032423242'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index ) => buildUSerItem(users[index]),
          separatorBuilder: (context, index ) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: users.length)
    );

  }
  Widget buildUSerItem(UserModel user) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25.0,
          child: Text('${user.id}',style: TextStyle( fontSize: 30.0),),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),),
            Text('${user.phone}',style: TextStyle(color: Colors.grey),)
          ],
        )
      ],
    ),
  );
}
