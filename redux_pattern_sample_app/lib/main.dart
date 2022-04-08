import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_pattern_sample_app/reducer/todo_list_reducer.dart';
import 'package:redux_pattern_sample_app/state/app_state.dart';
import 'package:redux_pattern_sample_app/todo_list/view/todo_list.dart';

void main() async {
  // enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store<AppState>(todoListReducer, initialState: AppState.initial());

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: StoreProvider<AppState>(
          store: store,
          child: const TodoList(),
        ),
      ),
    );
  }
}
