import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../events/todo_events.dart';
import '../states/todo_state.dart';
import '../models/todo.dart';

// BLoC (übersetzt Ereignisse -> Zustand)
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Uuid _uuid = const Uuid();

  TodoBloc() : super(const TodoState()) {
    // Todo hinzufügen
    on<TodoAdded>((event, emit) {
      final newTodo = Todo(id: _uuid.v4(), title: event.title);
      final updatedTodos = [...state.todos, newTodo];
      emit(state.copyWith(todos: updatedTodos));
    });

    // Todo entfernen
    on<TodoRemoved>((event, emit) {
      final updatedTodos =
          state.todos.where((todo) => todo.id != event.id).toList();
      emit(state.copyWith(todos: updatedTodos));
    });

    // Todo umschalten (completed/uncompleted)
    on<TodoToggled>((event, emit) {
      final updatedTodos =
          state.todos.map((todo) {
            if (todo.id == event.id) {
              return todo.copyWith(isCompleted: !todo.isCompleted);
            }
            return todo;
          }).toList();

      emit(state.copyWith(todos: updatedTodos));
    });

    // Todo aktualisieren
    on<TodoUpdated>((event, emit) {
      final updatedTodos =
          state.todos.map((todo) {
            if (todo.id == event.id) {
              return todo.copyWith(title: event.title);
            }
            return todo;
          }).toList();
      emit(state.copyWith(todos: updatedTodos));
    });

    // Todos laden (für zukünftige Implementierung mit persistent storage)
    on<TodosLoaded>((event, emit) {
      // Hier könnte man Todos aus einer Datenbank oder SharedPreferences laden
      // Für jetzt einfach den aktuellen State beibehalten
      emit(state);
    });

    // Alle Todos löschen
    on<TodosCleared>((event, emit) {
      emit(state.copyWith(todos: []));
    });
  }
}
