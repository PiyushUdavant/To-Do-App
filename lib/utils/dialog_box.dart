import 'package:flutter/material.dart';
import 'package:to_do_app/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox({
    super.key , 
    required this.controller, 
    required this.onSave, 
    required this.onCancel
  });

  // final TextEditingController _controller = TextEditingController();
  // (Since we need to access the controller on the homepage we need to define it on the homepage only. Here we just need to declare it as it will be needed us on the Homepage in the dialog box as a parameter.)

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Add a new task',
                  hintStyle: TextStyle(
                    fontSize: 17,
                  ),
                  border: OutlineInputBorder(
                    // borderSide: BorderSide(
                    //   color: Colors.grey,
                    // ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height:20,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                MyButton(
                  onPressed: onSave,
                  text: "Save",
                ),
                const SizedBox(
                  width:8,
                ),
                MyButton(
                  text: "Cancel", 
                  onPressed: onCancel,
                ),
              ]
            )
          ]
        )

      )
    );
  }
}