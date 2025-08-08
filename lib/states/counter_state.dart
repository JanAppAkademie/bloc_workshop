// Counter-Zustand (wie sieht es aus?)
class CounterState {
  final int value;
  final String? message;
  final bool isLoading;

  const CounterState(this.value, {this.message, this.isLoading = false});

  CounterState copyWith({int? value, String? message, bool? isLoading}) {
    return CounterState(
      value ?? this.value,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CounterStateLoading extends CounterState {
  const CounterStateLoading() : super(0);
}

class CounterStateLoaded extends CounterState {
  const CounterStateLoaded(super.value);
}
