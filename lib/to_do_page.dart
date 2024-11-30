import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/to_do_database.dart';
import 'package:to_do_app/utils/dialog_box.dart';
import 'package:to_do_app/utils/to_do_tile.dart';

class TODoPage extends StatefulWidget {
  const TODoPage({super.key});

  @override
  State<TODoPage> createState() => _TODoPageState();
}

class _TODoPageState extends State<TODoPage> {
  // Reference the Hive Database
  final _myBox = Hive.box('MyBox');
  ToDoDatabase db = ToDoDatabase();
  
  final TextEditingController _controller = TextEditingController();
  
  // // List Of Tasks (Becaues of Hive no need of this List here)
  // List toDoList = [
  //   ['Completed Tutorial' , false],
  //   ['Do Excercise' , true],
  //   ['Drink 5L Water' , false],
  // ];


  @override
  void initState() {
    super.initState();
    // If this is the first time ever opening the app , create the default tasks
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }
    else{
    // Data Already Exists so just load the data
      db.loadData();
    }
  }
  // Checkbox was tapped 
  void checkBoxChanged(bool? value,int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    // Since checkbox changed , value changed hence need to update the database
    db.updateDataBase();
  }
  
  // Save New Task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    // Since task added , value changed hence need to update the database
    db.updateDataBase();
  }

  // Create New Task
  void createNewTask(){
    showDialog(
      context: context,
      builder:(context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    // No need to add , as here we are just creating the task and not saving it yet. So , after save we already adding the data to databse in saveNewTask.
  }


  // Delete Task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    // Since task deleted , data changed hence need to update the database
    db.updateDataBase();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 232, 232, 11),
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text(
          'To-Do',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: createNewTask,
        child: const Icon(
          Icons.add,
          color: Colors.white, 
          size: 30,
        )
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context , index){
            return ToDoTile(
              // Pointing to the String in sublist of the toDoList
              taskName: db.toDoList[index][0], 
              // Pointing to the Boolean Value in sublist of the toDoList,
              taskCompleted: db.toDoList[index][1],
              // Function to be defined for each to do tile for OnTap ability of CheckBox
              onChanged: (value) => checkBoxChanged(value , index),
              deleteFunction: (context) => deleteTask(index),
            );
          }
        ),
      ),

      // This is what I thought for floating button. Yes, I am dumb.

      // floatingActionButton: Container(
      //   height: 50,
      //   width: 50,
      //   decoration: const BoxDecoration(
      //     color: Colors.black,
      //     shape: BoxShape.circle,
      //   ),
      //   child: IconButton(
      //     onPressed:() {},
      //     icon: const Icon(
      //       size: 30,
      //       Icons.add,
      //       color: Colors.white,
      //     ),
      //   )
      // ),
    );
  }
}