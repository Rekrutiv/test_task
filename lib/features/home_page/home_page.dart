import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/common/widgets/custom_dialogue.dart';
import 'package:test_task/features/home_page/bloc/home_page_bloc.dart';
import 'package:test_task/features/home_page/widgets/home_body_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home screen',
        ),
      ),
      body: BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (!state.isUrlValid!) {
            showDialog(
              context: context,
              builder: (context) {
                return const CustomDialogue(
                  title: 'Invalid URL input',
                  content: 'Please, correct your URL, and try again',
                );
              },
            );
          } else {
            Navigator.pushNamed(
              context,
              '/process',
              arguments: {
                'submittedUrl': state.apiUrl,
              },
            );
          }
        },
        child: HomeBodyWidget(),
      ),
    );
  }
}
