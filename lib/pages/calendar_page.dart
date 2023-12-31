import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_your_pills/cubit/calendar_cubit.dart';
import 'package:take_your_pills/remote_data_source.dart';
import 'package:take_your_pills/repository.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CalendarCubit(Repository(RemoteDataSource()))..start(),
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          final dataModels = state.dataModels;
          return Scaffold(
            body: Center(
              child: Expanded(
                child: ListView(children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: Text(
                              "Wziąłeś swoje tabletki",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          for (final dataModel in dataModels) ...[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.black),
                                  color: Color.fromARGB(157, 150, 75, 5)),
                              child: Column(
                                children: [
                                  Text(
                                    "Data: ${dataModel.date}, ",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Status: ${dataModel.isTaken}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ]
                        ]),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
