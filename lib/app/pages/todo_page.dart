// ignore_for_file: unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/app/pages/widgets/todo_item.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // Criando controlador
  final TextEditingController _todoController = TextEditingController();

  List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //! CRIAR UMA APP BAR PERSONALIZADA
        // appBar: AppBar(title: const Text('Todo list')),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildHeaderList(),
                const SizedBox(height: 20),
                _buildElevatedButton(),
                const SizedBox(height: 20),
                _buildListView(),
                const SizedBox(height: 20),
                _buildRowInfoButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderList() => Column(
        children: [
          Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Lista de tarefas',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
              Icon(Icons.list, size: 52),
            ],
          ),
          const Text('Projeto desenvolvido para estudos', style: TextStyle( fontSize: 10),),
        ],
      );

  Widget _buildElevatedButton() => Row(
        children: [
          Expanded(
            child: TextField(
                controller: _todoController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Adicione uma nova tarefa'),
                    hintText: 'Ex. Estudar Flutter')),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
              onPressed: () {
                String text = _todoController.text;
                setState(() {
                  todos.add(text);
                });
                _todoController.clear();
              },
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              child: const Icon(
                Icons.add,
                size: 25,
              ))
        ],
      );

  Widget _buildListView() => Flexible(
    child: ListView(
          shrinkWrap: true,
          children: [
            for (String todo in todos)
              TodoItem(
                title: todo,
              ),
          ],
        ),
  );

  Widget _buildRowInfoButton() => Row(
        children: [
          const Expanded(
              child: Text('você tem 0 tarefas pendentes',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700))),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('limpar tudo'),
          ),
        ],
      );
}
