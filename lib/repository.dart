import 'package:take_your_pills/models/data_model.dart';
import 'package:take_your_pills/remote_data_source.dart';

class Repository {
  Repository(this._remoteDataSource);

  final RemoteDataSource _remoteDataSource;

  Stream<List<DataModel>> getDataModel() {
    return _remoteDataSource.dataStream().map((event) => event.docs
        .map(
          (e) => DataModel(
            date: e['date'],
            isTaken: e['istaken'],
          ),
        )
        .toList());
  }

  Future<void> add({required String date, required bool isTaken}) async {
    await _remoteDataSource.add(date: date, isTaken: isTaken);
  }
}
