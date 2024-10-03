import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Widgets/InputDataSection.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/SearchForLoactionCubit/search_for_loaction_cubit.dart';

// ignore: must_be_immutable
class SearchTextFieldWithSuggesstions extends StatelessWidget {
  const SearchTextFieldWithSuggesstions({super.key, required this.suggestions});

  static String? searchContent;
  final List<PositionEntity> suggestions;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<PositionEntity>(
      displayStringForOption: (option) {
        return option.place;
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<PositionEntity>.empty();
        }
        return suggestions.where((PositionEntity option) {
          return option.place.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (PositionEntity option) {
        BlocProvider.of<SearchForLoactionCubit>(context).place = option.place;
        BlocProvider.of<SearchForLoactionCubit>(context).choosePoistionEntity(option);
      },
      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
        textEditingController.text = BlocProvider.of<SearchForLoactionCubit>(context).place;
        return InputDataSection(
          controller: textEditingController,
          focusNode: focusNode,
          onSaved: (value) {
            searchContent = value;
          },
          onChanged: (value) {
            BlocProvider.of<SearchForLoactionCubit>(context).place = value ?? "";
          },
          title: 'Destination',
        );
      },
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<PositionEntity> onSelected, Iterable<PositionEntity> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              width: 300.0,
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final PositionEntity option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option.place),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
