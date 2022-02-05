// ignore_for_file: unused_element

import 'package:flutter/material.dart';
class TodoPage extends StatelessWidget {
  const TodoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo list')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildHeaderList(),
              const SizedBox(height: 20),
              _buildElevatedButton(),
              _buildRowInfoButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderList() => Row(
    children: const [
       Text('Lista de tarefas',
        style: TextStyle(
          fontWeight: FontWeight.w600, 
          fontSize: 25
          )
        ),
       Icon(Icons.list, size: 52)
    ],    
  );

  Widget _buildElevatedButton() => Row(
    children: [
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Adicione uma nova tarefa'),
            hintText: 'Ex. Estudar Flutter'
            )
         ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16)
          ),
          child: const Icon(Icons.add, size: 25,)
        )
      ],
  );
  Widget _buildRowInfoButton() => Row(
    children: [
      const Expanded(
        child: Text(
          'você tem 0 tarefas pendentes',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700)
            )
          ),
      const SizedBox(width: 8),
      ElevatedButton(
        onPressed: (){},
        child: const Text('limpar tudo'),
      ),
    ],
  );

}
