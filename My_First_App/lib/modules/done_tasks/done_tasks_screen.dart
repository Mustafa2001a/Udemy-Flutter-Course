import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/todo_cubit.dart';
import '../../shared/cubit/todo_states.dart';

class DoneTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){

      },
      builder: (context, state){
        var task_ = AppCubit.get(context).doneTasks;
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
                  Icon(Icons.check_circle_outline,size: 50.0,color: Colors.grey[600],),
                  Text(
                    'No Tasks Done Yet',
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
