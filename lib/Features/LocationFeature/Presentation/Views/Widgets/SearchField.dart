import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/Widgets/InputDataSection.dart';

// ignore: must_be_immutable
class SearchField extends StatelessWidget {
  SearchField({super.key});
  String? searchContent;
  AutovalidateMode autovalidateMode = AutovalidateMode.always;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          InputDataSection(
            onSaved: (value) {
              searchContent = value;
            },
            title: 'Destination',
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    }
                  },
                  title: 'Search',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
