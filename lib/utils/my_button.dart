import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.yellow,
      enableFeedback: true,
      child: Text(text),
    );

    // Button I Thought of :

    // TextButton(
    //   onPressed: () {} ,
    //   style: const ButtonStyle(
    //     backgroundColor: WidgetStatePropertyAll(Colors.yellow),
    //     shape: WidgetStatePropertyAll(
    //       RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(20)),
    //       ),
    //     ),
    //   ),
    //   child: const Text(
    //     'Cancel',
    //     style: TextStyle(
    //       color: Colors.black,
    //     )
    //     ),
    // ),
  }
}