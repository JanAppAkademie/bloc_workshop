// Todo-Ereignisse (was kann passieren?)
abstract class TodoEvent {}

class TodoAdded extends TodoEvent {
  final String title;

  TodoAdded(this.title);
}

class TodoRemoved extends TodoEvent {
  final String id;

  TodoRemoved(this.id);
}

class TodoToggled extends TodoEvent {
  final String id;

  TodoToggled(this.id);
}

class TodoUpdated extends TodoEvent {
  final String id;
  final String title;
  final String description;

  TodoUpdated({
    required this.id,
    required this.title,
    required this.description,
  });
}

class TodosLoaded extends TodoEvent {}

class TodosCleared extends TodoEvent {}
