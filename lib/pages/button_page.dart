import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:take_your_pills/cubit/data_cubit.dart';
import 'package:take_your_pills/pages/calendar_page.dart';
import 'package:take_your_pills/remote_data_source.dart';
import 'package:take_your_pills/repository.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({
    super.key,
    required this.formattedDate,
  });

  final String formattedDate;
  final isTaken = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataCubit(Repository(RemoteDataSource())),
      child: BlocConsumer<DataCubit, DataState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Weź tabletki",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.amber,
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Data: $formattedDate",
                      style: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Wziąłeś tabletki?",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Material(
                      clipBehavior: Clip.hardEdge,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(120)),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<DataCubit>()
                              .add(date: formattedDate, isTaken: isTaken);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const CalendarPage()),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 240,
                          width: 240,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(120),
                              border:
                                  Border.all(width: 4, color: Colors.black)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Wziąłem tabletki",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
