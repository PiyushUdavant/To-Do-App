import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/provider_to_do_page.dart';
// import 'package:to_do_app/to_do_page.dart';

void main() async {
  // Intialize the Hive 
  await Hive.initFlutter();

  // Open the MyBox Database
  await Hive.openBox('MyBox');
  runApp(const ProviderScope(child: ToDoApp()));
}


class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.yellow,
        ),
        debugShowCheckedModeBanner: false,
        home: const TODoPageUsingProvider(),
    );
  }
}