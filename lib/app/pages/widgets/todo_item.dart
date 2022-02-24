import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {

  const TodoItem({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(14.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Text('24/02/2022', style: TextStyle(fontSize: 10),),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}