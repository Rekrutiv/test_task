import 'package:flutter/material.dart';
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
      body:  HomeBodyWidget(),

    );
  }
}
