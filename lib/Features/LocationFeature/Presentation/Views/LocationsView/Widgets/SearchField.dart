import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsView/Widgets/SearchTextFieldWithSuggesstions.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/SearchForLoactionCubit/search_for_loaction_cubit.dart';

// ignore: must_be_immutable
class SearchField extends StatelessWidget {
  SearchField({super.key, required this.suggestions});
  AutovalidateMode autovalidateMode = AutovalidateMode.always;
  final GlobalKey<FormState> formKey = GlobalKey();
  final List<PositionEntity> suggestions;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          SearchTextFieldWithSuggesstions(suggestions: suggestions),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await BlocProvider.of<SearchForLoactionCubit>(context).searchForLoaction(SearchTextFieldWithSuggesstions.searchContent!);
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
