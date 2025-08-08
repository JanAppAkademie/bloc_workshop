import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/counter_events.dart';
import '../states/counter_state.dart';

// BLoC (übersetzt Ereignisse -> Zustand)
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    // +1
    on<CounterIncremented>(
      (event, emit) =>
          emit(state.copyWith(value: state.value + 1, message: '++')),
    );

    // -1
    on<CounterDecremented>(
      (event, emit) =>
          emit(state.copyWith(value: state.value - 1, message: '--')),
    );

    // Reset
    on<CounterReset>((event, emit) {

      
      emit(const CounterState(0, message: 'Zurückgesetzt', isLoading: true));
    });

    // Set to fixed value (validiert >= 0)
    on<CounterSetTo>((event, emit) {
      if (event.value < 0) {
        emit(state.copyWith(message: 'Negativer Wert nicht erlaubt'));
      } else {
        emit(CounterState(event.value, message: 'Auf ${event.value} gesetzt'));
      }
    });

    // Erhöhe um amount
    on<CounterIncrementBy>((event, emit) {
      emit(
        state.copyWith(
          value: state.value + event.amount,
          message: '+${event.amount}',
        ),
      );
    });
  }
}
