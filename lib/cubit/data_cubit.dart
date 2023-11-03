import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:take_your_pills/models/data_model.dart';
import 'package:take_your_pills/repository.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit(this._repository)
      : super(DataState(errorMessage: '', dataModels: []));

  final Repository _repository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(DataState(errorMessage: '', dataModels: []));

    try {
      _streamSubscription = _repository.getDataModel().listen((dataModels) {
        emit(DataState(errorMessage: '', dataModels: dataModels));
      });
    } catch (error) {
      emit(DataState(errorMessage: error.toString(), dataModels: []));
    }
  }

  Future<void> add({required String date, required bool isTaken}) async {
    _repository.add(date: date, isTaken: isTaken);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
