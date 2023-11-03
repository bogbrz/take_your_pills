import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:take_your_pills/models/data_model.dart';
import 'package:take_your_pills/repository.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._repository)
      : super(CalendarState(errorMessage: '', dataModels: []));

  final Repository _repository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _repository.getDataModel().listen((dataModels) {
      emit(CalendarState(errorMessage: '', dataModels: dataModels));
      print(dataModels);
    })
      ..onError((error) {
        emit(CalendarState(errorMessage: error.toString(), dataModels: []));
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
