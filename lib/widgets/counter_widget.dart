import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/counter_bloc.dart';
import '../states/counter_state.dart';
import '../events/counter_events.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  Future<void> _showSetDialog(BuildContext context) async {
    final controller = TextEditingController(text: '0');
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Wert setzen'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              final v = int.tryParse(controller.text);
              if (v != null) Navigator.pop(ctx, v);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (result != null) context.read<CounterBloc>().add(CounterSetTo(result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einfaches BLoC Beispiel'),
        actions: [
          IconButton(
            tooltip: context.read<CounterBloc>().state.toString(), //
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CounterBloc>().add(CounterReset());
            },
          ),
          IconButton(
            tooltip: 'Wert setzen',
            icon: const Icon(Icons.edit),
            onPressed: () => _showSetDialog(context),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state is CounterStateLoading)
                  const CircularProgressIndicator(),
                Text(
                  '${state.value}',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                if (state.message != null)
                  Text(
                    state.message!,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'inc',
            onPressed: () =>
                context.read<CounterBloc>().add(CounterIncremented()),
            label: const Text('Plus'),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'dec',
            onPressed: () =>
                context.read<CounterBloc>().add(CounterDecremented()),
            label: const Text('Minus'),
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
