import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/common/styles/app_styles.dart';
import 'package:test_task/common/widgets/custom_btn.dart';
import 'package:test_task/features/home_page/bloc/home_page_bloc.dart';

class HomeBodyWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  HomeBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set valid API base URL in order to continue',
            textAlign: TextAlign.start,
            style: AppStyles.textStyle,
          ),
          Row(
            children: [
              const Icon(Icons.compare_arrows_rounded),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'URL',
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          CustomButton(
            onTapButton: () {
              context.read<HomePageBloc>().add(
                    UrlSubmitted(
                      url: controller.text,
                    ),
                  );
            },
            text: 'Start counting process',
          ),
        ],
      ),
    );
  }
}
