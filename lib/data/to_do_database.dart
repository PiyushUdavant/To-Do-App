import 'package:hive/hive.dart';

class ToDoDatabase {
  final _myBox = Hive.box('MyBox');
  List toDoList = [];

  // Run this method if this is 1st time ever opening the app
  void createInitialData(){
    toDoList = [
      ['Drink Water' , false],
      ['Do Excercise' , false],
    ];
  }
  
  // Load the data from Database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  // To update the existing toDoList
  void updateDataBase(){
    _myBox.put("TODOLIST" , toDoList);
  }
}