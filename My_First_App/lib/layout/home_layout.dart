import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/cubit/todo_cubit.dart';
import 'package:my_first_app/shared/cubit/todo_states.dart';
import 'package:sqflite/sqflite.dart';
import '../modules/archived_tasks/archived_tasks_screen.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';
import '../shared/components/constants.dart';

class HomeLayout extends StatelessWidget {

  TextEditingController titleConroller = TextEditingController();
  TextEditingController timeConroller = TextEditingController();
  TextEditingController dateConroller = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit,AppStates>(
       listener: (context,state)
        {
          if(state is AppInsertState)
            {
              Navigator.pop(context);
              titleConroller.text = '';
              timeConroller.text = '';
              dateConroller.text = '';
            }
        },
        builder: (context,state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: cubit.titles[cubit.currIndex],
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: state is! AppGetDBLoadingState,
            builder: (context) => cubit.screens[cubit.currIndex],
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(cubit.floatingActionButton),
              onPressed: () {
                // var name = await getName();
                // print(name);
                // InsertRecordtoDB();
                if (cubit.isButtonSheet) {
                  if (formKey.currentState!.validate()) {
                    cubit.InsertRecordtoDB(
                        title: titleConroller.text,
                        time: timeConroller.text,
                        date: dateConroller.text
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Form(
                      key: formKey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                              controller: titleConroller,
                              input_type: TextInputType.text,
                              lb_text: 'Task Title',
                              validFuction: (value) {
                                if (value!.isEmpty) {
                                  return 'Title must not be empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: timeConroller,
                              input_type: TextInputType.none,
                              lb_text: 'Task Time',
                              prefix: Icons.watch_later_outlined,
                              onTapFunction: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeConroller.text =
                                      value!.format(context).toString();
                                });
                              },
                              validFuction: (value) {
                                if (value!.isEmpty) {
                                  return 'Time must not be empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: dateConroller,
                              input_type: TextInputType.none,
                              lb_text: 'Task Date',
                              prefix: Icons.calendar_month,
                              onTapFunction: () {
                                showDatePicker(
                                  context: context,
                                  lastDate: DateTime.parse('2022-08-29'),
                                  firstDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                ).then((value) {
                                  dateConroller.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              validFuction: (value) {
                                if (value!.isEmpty) {
                                  return 'Date must not be empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),

                    ),
                    elevation: 20.0,
                  )
                      .closed
                      .then((value){
                        cubit.ChangeBottonSheetState(isShown: false, icon: Icons.edit);
                  });
                  cubit.ChangeBottonSheetState(isShown: true, icon: Icons.add);
                }
              },
              ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ]),
        );
        }

      ),
    );
  }

  // Future<String> getName() async {
  //   return 'Mustafa Shihab';
  // }


}
