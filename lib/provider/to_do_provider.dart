import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ToDoNotifier extends StateNotifier<List<List<dynamic>>>{
  ToDoNotifier() : super([]){
    _loadData();
  }

  final Box _myBox = Hive.box('MyBox');

  // Load the data from Hive
  void _loadData(){
    final savedData = _myBox.get("TODOLIST") as List<dynamic>? ?? [];
    state = List<List<dynamic>>.from(savedData);
  }

  // Add a new task
  void addTask(String task){
    state = [...state,[task , false]];
    _updateDatabase();
  }

  // Update a task's completion status
  void toggleTask(int index){
    state[index][1] = !state[index][1];
    state = [...state];
    _updateDatabase();
  }

  // Delete a task
  void deleteTask(int index){
    state.removeAt(index);
    state = [...state];
    _updateDatabase();
  }

  // Update the database
  void _updateDatabase(){
    _myBox.put("TODOLIST" , state);
  }
}
  // Riverpod Provider for ToDoNotifier
  final toDoProvider = StateNotifierProvider<ToDoNotifier,List<List<dynamic>>>((ref){
    return ToDoNotifier();
  });