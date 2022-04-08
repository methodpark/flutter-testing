import 'package:bloc_pattern_sample_app/services/http_service.dart';
import 'package:bloc_pattern_sample_app/todo_list/bloc/todo_list_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  late MockHttpService httpService;
  const dataFromServer = TodoList([TodoListItem(text: 'foo')]);
  const seededState =
      ChangedTodoListState(TodoList([TodoListItem(text: 'seed')]));

  setUpAll(() {
    registerFallbackValue(const TodoList.empty());
  });

  setUp(() {
    httpService = MockHttpService();
    when(() => httpService.storeOnServer(any(that: isA<TodoList>())))
        .thenAnswer((invocation) async => dataFromServer);
  });

  group('TodoListBloc', () {
    group('loading data from the server', () {
      setUp(() {
        when(() => httpService.loadFromServer())
            .thenAnswer((invocation) async => dataFromServer);
      });

      blocTest<TodoListBloc, TodoListState>(
        'emits the data from the server',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(LoadListFromBackend()),
        skip: 1,
        expect: () => [
          const ChangedTodoListState(dataFromServer),
        ],
      );

      blocTest<TodoListBloc, TodoListState>(
        'first emits a loading state with the current model',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(LoadListFromBackend()),
        seed: () => seededState,
        expect: () => [
          LoadingTodoListState(seededState.model),
          const ChangedTodoListState(dataFromServer),
        ],
      );
    });

    group('adding an item', () {
      const itemToAdd = TodoListItem(text: 'first item', isChecked: false);
      final expectedList = TodoList([...seededState.model.items, itemToAdd]);

      blocTest<TodoListBloc, TodoListState>(
        'uploads the uncompleted item to the server',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(const AddTodoListItem('first item')),
        seed: () => seededState,
        verify: (bloc) => verify(
          () => httpService.storeOnServer(expectedList),
        ).called(1),
      );

      blocTest<TodoListBloc, TodoListState>(
        'emits a loading state with the new item and the data from the server',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(const AddTodoListItem('first item')),
        seed: () => seededState,
        expect: () => [
          LoadingTodoListState(expectedList),
          const ChangedTodoListState(dataFromServer),
        ],
      );
    });

    group('removing an item', () {
      blocTest<TodoListBloc, TodoListState>(
        'uploads the list without the item to the server',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(const RemoveTodoListItem(0)),
        seed: () => seededState,
        verify: (bloc) => verify(
          () => httpService.storeOnServer(const TodoList.empty()),
        ).called(1),
      );

      blocTest<TodoListBloc, TodoListState>(
        'emits a loading state without the item and the data from the server',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(const RemoveTodoListItem(0)),
        seed: () => seededState,
        expect: () => [
          const LoadingTodoListState(TodoList.empty()),
          const ChangedTodoListState(dataFromServer),
        ],
      );

      blocTest<TodoListBloc, TodoListState>(
        'throws an error when removing a nonexistent item',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(const RemoveTodoListItem(1)),
        errors: () => [isA<RangeError>()],
      );
    });
    group('checking an item', () {
      const expectedList =
          TodoList([TodoListItem(text: 'seed', isChecked: true)]);

      blocTest<TodoListBloc, TodoListState>(
        'uploads the completed item to the server',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(const CheckTodoListItem(0)),
        seed: () => seededState,
        verify: (bloc) => verify(
          () => httpService.storeOnServer(expectedList),
        ).called(1),
      );

      blocTest<TodoListBloc, TodoListState>(
        'emits a loading state with a checked item and the data from the server',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(const CheckTodoListItem(0)),
        seed: () => seededState,
        expect: () => [
          const LoadingTodoListState(expectedList),
          const ChangedTodoListState(dataFromServer)
        ],
      );
    });

    group('unchecking an item', () {
      const seededState = ChangedTodoListState(
          TodoList([TodoListItem(text: 'seed', isChecked: true)]));

      const expectedList =
          TodoList([TodoListItem(text: 'seed', isChecked: false)]);

      blocTest<TodoListBloc, TodoListState>(
        'uploads the uncompleted item to the server',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(const UncheckTodoListItem(0)),
        seed: () => seededState,
        verify: (bloc) => verify(
          () => httpService.storeOnServer(expectedList),
        ).called(1),
      );

      blocTest<TodoListBloc, TodoListState>(
        'emits a loading state with an unchecked item and the data from the server',
        build: () => TodoListBloc(httpService),
        act: (bloc) => bloc.add(const UncheckTodoListItem(0)),
        seed: () => seededState,
        expect: () => [
          const LoadingTodoListState(expectedList),
          const ChangedTodoListState(dataFromServer)
        ],
      );
    });
  });
}
