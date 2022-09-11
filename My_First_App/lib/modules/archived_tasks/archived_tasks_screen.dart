import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/cubit/todo_cubit.dart';
import 'package:my_first_app/shared/cubit/todo_states.dart';

class ArchivedTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){

      },
      builder: (context, state){
        var task_ = AppCubit.get(context).archivedTasks;
        return ConditionalBuilder(
          condition: task_.isNotEmpty,
          builder: (BuildContext context)
          {
            return ListView.separated(
              itemBuilder: (context,index) => tasks(task_[index],context),
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  color: Colors.grey[300],
                  height: 2.0,
                  width: double.infinity,
                ),
              ),
              itemCount: task_.length,
            );
          },
          fallback: (BuildContext context)
          {
            return Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.archive_outlined,size: 50.0,color: Colors.grey[600],),
                  Text(
                    'No Tasks Archived Yet',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  )
                ],
              ),
            );
          },

        );
      },
    );
  }
}
