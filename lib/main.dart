import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/todo_bloc.dart';
import 'widgets/todo_widget.dart';

void main() {
  runApp(const BlocWorkshopApp());
}

class BlocWorkshopApp extends StatelessWidget {
  const BlocWorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Workshop',
      theme: ThemeData.dark(),
      home: const BlocWorkshopHome(),
    );
  }
}

class BlocWorkshopHome extends StatelessWidget {
  const BlocWorkshopHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('BLoC Workshop'),
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => TodoBloc())],
        child: BlocWorkshopContent(),
      ),
    );
  }
}

class BlocWorkshopContent extends StatelessWidget {
  const BlocWorkshopContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoWidget();
  }
}
