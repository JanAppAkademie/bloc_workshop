// Counter-Ereignisse (was kann passieren?)
abstract class CounterEvent {}

class CounterIncremented extends CounterEvent {}

class CounterDecremented extends CounterEvent {}

class CounterReset extends CounterEvent {}

class CounterSetTo extends CounterEvent {
  final int value;
  CounterSetTo(this.value);
}

class CounterIncrementBy extends CounterEvent {
  final int amount;
  CounterIncrementBy(this.amount);
}

class CounterIncrementDelayed extends CounterEvent {
  final int amount;
  final Duration delay;
  CounterIncrementDelayed({
    this.amount = 5,
    this.delay = const Duration(seconds: 1),
  });
}
