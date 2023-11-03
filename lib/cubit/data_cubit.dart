import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:take_your_pills/repository.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit(this._repository)
      : super(DataState(errorMessage: '', isAdded: false));

  final Repository _repository;

  Future<void> add({required String date, required String isTaken}) async {
    try {
      await _repository.add(date: date, isTaken: isTaken);
      emit(DataState(errorMessage: '', isAdded: true));
    } catch (error) {
      emit(DataState(errorMessage: error.toString(), isAdded: false));
    }
  }
}
