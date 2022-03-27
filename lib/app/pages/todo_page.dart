// ignore_for_file: unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/app/models/todo.dart';
import 'package:todo_list/app/pages/widgets/todo_item.dart';
import 'package:todo_list/app/repositories/todo_repository.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // Criando controlador
  final TextEditingController _todoController = TextEditingController();

  // Instanciando o repository para o sharedPreferences
  final TodoRepository _todoRepository = TodoRepository();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? todoPosition;
  String? mensagemDeErro;

  @override
  void initState() {
    super.initState();
    _todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('Lista de tarefas',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
              Icon(Icons.list, size: 52),
            ],
          ),
          const Text(
            'Projeto desenvolvido para estudos',
            style: TextStyle(fontSize: 10),
          ),
        ],
      );

  Widget _buildElevatedButton() => Row(
        children: [
          Expanded(
            child: TextField(
                controller: _todoController,
                decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Adicione uma nova tarefa'),
                    hintText: 'Ex. Estudar Flutter',
                    errorText: mensagemDeErro,
                    )
                    ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
              onPressed: () {
                String text = _todoController.text;

                if(text.isEmpty){
                  setState(() {
                    mensagemDeErro = 'Por favor informe sua tarefa';
                  });
                  return;
                }
                setState(() {
                  Todo newTodo = Todo(title: text, dateTime: DateTime.now());
                  todos.add(newTodo);
                });
                _todoController.clear();
                _todoRepository.saveTodoList(todos);
              },
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              child: const Icon(
                Icons.task_alt,
                size: 25,
              ))
        ],
      );

  Widget _buildListView() => Expanded(
    flex: 5,
        child: ListView(
          shrinkWrap: true,
          children: [
            for (Todo todo in todos)
              TodoItem(
                todo: todo,
                onDelete: onDelete,
              ),
          ],
        ),
      );

  Widget _buildRowInfoButton() => Flexible(
    child: Row(
      children: [
          Expanded(
              child: Text('você tem ${todos.length} tarefas pendentes',
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700))),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: showDeleteDialog,
            child: const Text('limpar tudo'),
          ),
        ],
    ),
  );


  void onDelete(Todo todo) {
    deletedTodo = todo;
    todoPosition = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
      _todoRepository.saveTodoList(todos);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Testando, removido: ${todo.title}'),
      action: SnackBarAction(
        textColor: Colors.red,
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            todos.insert(todoPosition!, deletedTodo!);
            _todoRepository.saveTodoList(todos);
          });
        },
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  void showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Limpar tudo ?'),
              content: const Text('Deseja realmente apagar todas as tarefas ?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      deleteAllTodos();
                    },
                    child: const Text(
                      'Deletar tudo',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ));
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
      _todoRepository.saveTodoList(todos);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Lista deletada'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    ));
  }
}
