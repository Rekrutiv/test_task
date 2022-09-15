import 'package:flutter/material.dart';
import 'package:test_task/common/constants.dart';
import 'package:test_task/common/styles/app_styles.dart';
import 'package:test_task/common/widgets/custom_btn.dart';

class HomeBodyWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  HomeBodyWidget({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
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
                  child: TextFormField(
                    controller: controller,
                    onChanged: (v) {
                      _formKey.currentState!.validate();
                    },
                    validator: (value) {
                      if (!value!.startsWith(baseUrl)) {
                        return 'must be not empty';
                      }

                      return null;
                    },
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
                _formKey.currentState?.validate() ?? false
                    ? Navigator.pushNamed(
                        context,
                        '/process',
                        arguments: {
                          'submittedUrl': baseUrl,
                        },
                      )
                    : null;
              },
              text: 'Start counting process',
            )
          ],
        ),
      ),
    );
  }
}
