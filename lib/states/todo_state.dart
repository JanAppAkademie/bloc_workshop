import '../models/todo.dart';

// Todo-Zustand (wie sieht es aus?)
class TodoState {
  final List<Todo> todos;
  final bool isLoading;
  final String? errorMessage;

  const TodoState({
    this.todos = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  TodoState copyWith({
    List<Todo>? todos,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  int get completedCount => todos.where((todo) => todo.isCompleted).length;
  int get totalCount => todos.length;
  int get pendingCount => totalCount - completedCount;

  @override
  String toString() {
    return 'TodoState(todos: ${todos.length}, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}
