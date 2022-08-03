import 'package:flutter_bloc/flutter_bloc.dart';

//cubit is a container that saves the state that is integer

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0 /**initial state */);
  //member functions exported by us
  void increment() {
    int newState = state + 1; //compute new state
    emit(newState); //emit the new state, propogate it to all listeners
  }

  void decrement() {
    int newState = state - 1;
    emit(newState);
  }

  void restart() {
    int newState = 0;
    emit(newState);
  }
}
