import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/shared/cubit/todo_states.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';
import '../components/constants.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currIndex = 0;

  List<Widget> titles = [
    Text('New Tasks'),
    Text('Done Tasks'),
    Text('Archived Tasks'),
  ];
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  void changeIndex(int index)
  {
    currIndex = index;
    emit(AppBottonNavBarState());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];


  void createDB() {
    openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          print('DB created');
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
              .then((database) {
            print('Table created');
          });
        }, onOpen: (database) {
          getDataFromDB(database);
          print('DB opened');
        }).then((value)
    {
      database = value;
      emit(AppCreateDBState());
    });
  }

  InsertRecordtoDB({
    required title,
    required time,
    required date,
  }) async {
    await database!.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO Tasks (title,date,time,status) VALUES("$title","$date","$time","new task")'
      ).then((value)
      {
        print('$value inserted successfully');
        emit(AppInsertState());
        getDataFromDB(database);
      }
      ).catchError((error)
      {
        print(error);
      }
      );
    });
  }

  void getDataFromDB(database) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDBLoadingState());
    await database!.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((element){
        if (element['status'] == 'new task')
        {
          newTasks.add(element);
        }
        else if (element['status'] == 'done')
        {
          doneTasks.add(element);
        }
        else
        {
          archivedTasks.add(element);
        }
      }
              );

      emit(AppGetDBState());

    });
  }

  IconData floatingActionButton = Icons.edit;
  bool isButtonSheet = false;


  void ChangeBottonSheetState({
  required bool isShown,
    required IconData icon,
})
  {
    floatingActionButton = icon;
    isButtonSheet = isShown;
    emit(AppBottonSheetState());
  }


  UpdateData({
    required String status,
    required int id,
})
  {
   database!.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', '$id']).then((value) {
          print('$status updated successfully');
        }).then((value) {
          getDataFromDB(database);
     emit(AppUpdateState());
   });

  }


  void DeleteDB({
    required int id
  }) async
  {
    database!.rawDelete(
        'DELETE FROM Tasks  WHERE id = ?',
        ['$id']
    );
    getDataFromDB(database);
    emit(AppDeleteState());
  }


}