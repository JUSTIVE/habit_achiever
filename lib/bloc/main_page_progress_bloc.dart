import 'package:bloc/bloc.dart';

enum TaskAction { SingleTaskDone, SingleTaskUndone }

class MainPageProgressBloc extends Bloc<TaskAction, double> {
  @override
  double get initialState => 0;

  @override
  Stream<double> mapEventToState(double currentState, TaskAction event) async* {
    switch (event) {
      case TaskAction.SingleTaskDone:
        currentState++;
        break;
      case TaskAction.SingleTaskUndone:
        currentState--;
        break;
    }
  }
}
