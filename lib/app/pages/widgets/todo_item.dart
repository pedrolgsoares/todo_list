import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

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
        children: [
          Text(
            DateFormat('dd/MM/yyyy -- HH:mm').format(todo.dateTime),
            style: const TextStyle(fontSize: 10),
          ),
          Text(
            todo.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
