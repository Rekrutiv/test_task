import 'package:flutter/material.dart';
import 'package:test_task/common/styles/app_styles.dart';

class CustomDialogue extends StatelessWidget {
  const CustomDialogue({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: AppStyles.textStyle,
      ),
      content: Text(
        content,
        style: AppStyles.textStyle,
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          style: AppStyles.buttonStyle,
          child: const Text(
            'Continue',
            style: AppStyles.textStyle,
          ),
        ),
      ],
    );
  }
}
