import 'package:bloc_pattern_sample_app/services/http_service.dart';
import 'package:bloc_pattern_sample_app/todo_list/view/todo_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/todo_list_bloc.dart';

typedef UnaryCallback<T> = void Function(T);
typedef BinaryCallback<T1, T2> = void Function(T1, T2);

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocProvider(
        create: (context) => TodoListBloc(
          context.read<HttpService>(),
        )..add(LoadListFromBackend()),
        child: const TodoListView(),
      ),
    );
  }
}
