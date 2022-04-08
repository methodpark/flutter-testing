import 'package:bloc_pattern_sample_app/services/http_service.dart';
import 'package:bloc_pattern_sample_app/todo_list/todo_list.dart' as view;
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

void main() {
  if (const bool.fromEnvironment('enableFlutterDriver', defaultValue: false)) {
    enableFlutterDriverExtension();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Testing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider(
        create: (context) => HttpService(
          httpClient: Client(),
          serverUrl: 'http://localhost:3000',
        ),
        child: const view.TodoListScreen(),
      ),
    );
  }
}
