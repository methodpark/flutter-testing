import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_model.dart';

class TodoListDto {
  late final TodoList list;

  TodoListDto(this.list);
  TodoListDto.fromJson(Map<String, dynamic> json) {
    final List<TodoListItem> items = [];

    for (final Map<String, dynamic> item in json['items'] ?? []) {
      if (!(item['isChecked'] is bool && item['text'] is String)) {
        continue;
      }
      items.add(item['isChecked']
          ? TodoListItem(text: item['text'], isChecked: true)
          : TodoListItem(text: item['text'], isChecked: false));
    }
    list = TodoList(items);
  }

  Map<String, List<Map<String, dynamic>>> toJson() => {
        "items": list.items.map((item) => {"text": item.text, "isChecked": item.isChecked}).toList()
      };
}
