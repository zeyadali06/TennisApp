import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Core/Widgets/ViewHeader.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/WeatherEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/CustomCalendar.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/WeatherStatistics.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Controllers/HomeViewCubit/home_view_cubit.dart';

// ignore: must_be_immutable
class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late WeatherEntity currentWeatherEntity;

  @override
  void initState() {
    currentWeatherEntity = WeatherEntity.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<HomeViewCubit, HomeViewState>(
      listener: (context, state) {
        if (state is HomeViewFailed) {
          showSnackBar(context, state.error.message);
        } else if (state is HomeViewSuccess) {
          currentWeatherEntity = state.currentWeatherEntity;
        } else if (state is GetPredictionSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Result'),
                content: () {
                  String text;
                  if (state.result) {
                    text = "You can go to do excercises";
                  } else {
                    text = "It's not good to go for training";
                  }
                  return Text(text);
                }.call(),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else if (state is GetPredictionFailed) {
          showSnackBar(context, state.error.message);
        }
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: CustomGradiantContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const ViewHeader(),
                      const SizedBox(height: 30),
                      CustomCalendar(
                        onDaySelected: (dateTime) async {
                          if (isSameDay(dateTime, DateTime.now())) {
                            await BlocProvider.of<HomeViewCubit>(context)
                                .getCurrentWeather();
                          } else {
                            DateTime date = DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              DateTime.now().hour,
                            );
                            await BlocProvider.of<HomeViewCubit>(context)
                                .getForecastWeather(date);
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      WeartherStatistics(
                        currentWeatherEntity: currentWeatherEntity,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () async =>
                                  await BlocProvider.of<HomeViewCubit>(context)
                                      .getPrediction(),
                              title: "Go To Excercise",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
