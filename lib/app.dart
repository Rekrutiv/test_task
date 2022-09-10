import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/home_page/bloc/home_page_bloc.dart';
import 'package:test_task/features/home_page/home_page.dart';
import 'package:test_task/features/preview_page/bloc/preview_page_bloc.dart';
import 'package:test_task/features/preview_page/preview_page.dart';
import 'package:test_task/features/process_page/bloc/process_page_bloc.dart';
import 'package:test_task/features/process_page/process_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(
          create: (context) => HomePageBloc(),
        ),
        BlocProvider<PreviewPageBloc>(
          create: (context) => PreviewPageBloc(),
        ),
        BlocProvider<ProcessPageBloc>(
          create: (context) => ProcessPageBloc(),
        ),

      ],
      child: MaterialApp(
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomePage(),
          '/preview': (context) => const PreviewPage(),
          '/process': (context) => const ProcessPage(),
        },
      ),
    );
  }
}
