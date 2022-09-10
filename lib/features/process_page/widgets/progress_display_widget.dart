import 'package:flutter/material.dart';
import 'package:test_task/features/process_page/bloc/process_page_bloc.dart';
import 'package:test_task/common/styles/app_styles.dart';

class ProgressDisplayWidget extends StatelessWidget {
  final ProcessPageState loadProgress;

  const ProgressDisplayWidget({
    Key? key,
    required this.loadProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loadProgress.progressMessage,
              style: AppStyles.textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Text(
              '${loadProgress.progressValue * 100}%',
              style: AppStyles.textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: 200.0,
              width: 200.0,
              child: CircularProgressIndicator(
                value: loadProgress.progressValue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
