import 'package:flutter/material.dart';
import 'package:test_task/common/styles/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTapButton
  }) : super(key: key);

  final String text;
  final  onTapButton;


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed:  onTapButton,

      style: AppStyles.buttonStyle,
      child:  Text(
        text,
        style: AppStyles.textStyle,
      ),
    );
  }
}
