import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:take_your_pills/cubit/calendar_cubit.dart';
import 'package:take_your_pills/firebase_options.dart';
import 'package:take_your_pills/pages/button_page.dart';
import 'package:take_your_pills/pages/calendar_page.dart';
import 'package:take_your_pills/remote_data_source.dart';
import 'package:take_your_pills/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('pl', null);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var formattedDate = DateFormat.yMd("pl").format(DateTime.now());
  var page = 1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CalendarCubit(Repository(RemoteDataSource()))..start(),
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          for (final dataModel in state.dataModels) {
            if (dataModel.date == formattedDate) {
              page = 2;
            }
          }
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Color.fromARGB(255, 2, 3, 2),
                  background: Colors.lightGreen),
              useMaterial3: true,
            ),
            home: page == 1
                ? ButtonPage(formattedDate: formattedDate)
                : const CalendarPage(),
          );
        },
      ),
    );
  }
}
