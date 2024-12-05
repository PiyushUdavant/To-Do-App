import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/utils/dialog_box.dart';
import 'package:to_do_app/utils/to_do_tile.dart';
import 'package:to_do_app/provider/to_do_provider.dart';

class TODoPageUsingProvider extends StatefulWidget {
  const TODoPageUsingProvider({super.key});

  @override
  State<TODoPageUsingProvider> createState() => _TODoPageState();
}

class _TODoPageState extends State<TODoPageUsingProvider> {
  final TextEditingController _controller = TextEditingController();

  void saveNewTask(BuildContext context, WidgetRef ref) {
    final toDoNotifier = ref.read(toDoProvider.notifier);
    toDoNotifier.addTask(_controller.text);
    _controller.clear();
    Navigator.of(context).pop();
  }

  void createNewTask(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () => saveNewTask(context, ref),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final toDoList = ref.watch(toDoProvider);
        final toDoNotifier = ref.read(toDoProvider.notifier);

        return Scaffold(
          backgroundColor: Colors.yellow[200],
          appBar: AppBar(
            backgroundColor: Colors.yellow,
            centerTitle: true,
            title: const Text(
              'To-Do',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () => createNewTask(context, ref),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
          body: Container(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: toDoList[index][0],
                  taskCompleted: toDoList[index][1],
                  onChanged: (value) => toDoNotifier.toggleTask(index),
                  deleteFunction: (context) => toDoNotifier.deleteTask(index),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
