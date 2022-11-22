import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_to_bloc/constants/enums.dart';
import 'internet_cubit.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  StreamSubscription? internetStream;
  CounterCubit({required this.internetCubit}) : super(CounterState(counterValue: 0, wasIncremented: true)) {
    check();
  }

  void check() {
    internetStream = internetCubit.stream.listen((event) {
      if (event is InternetConnected && event.connectionType == ConnectionType.Wifi) {
        increment();
      } else if (event is InternetConnected && event.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(counterValue: state.counterValue - 1, wasIncremented: false));
  @override
  Future<void> close() {
    internetStream!.cancel();
    return super.close();
  }
}
