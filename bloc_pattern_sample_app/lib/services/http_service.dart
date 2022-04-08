import 'dart:convert';

import 'package:bloc_pattern_sample_app/services/data_transfer_objects/todo_list.dart';
import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_model.dart';
import 'package:http/http.dart';

class HttpService {
  Client httpClient;
  String serverUrl;

  HttpService({
    required this.httpClient,
    required this.serverUrl,
  });

  Uri get _todoListUrl => Uri.parse('$serverUrl/list');

  Future<TodoList> loadFromServer() async {
    final request = await httpClient.get(_todoListUrl);

    return TodoListDto.fromJson(jsonDecode(request.body)).list;
  }

  Future<TodoList> storeOnServer(TodoList list) async {
    final request = await httpClient.post(
      _todoListUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(TodoListDto(list)),
    );

    return TodoListDto.fromJson(jsonDecode(request.body)).list;
  }
}
