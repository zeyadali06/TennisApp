import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Core/Utils/DependencyInjection.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Core/Widgets/ViewHeader.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/WeatherEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/GetPredictionUseCase.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/CustomCalendar.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/WeatherStatistics.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Controllers/HomeViewCubit/home_view_cubit.dart';

// ignore: must_be_immutable
class HomeViewBody extends StatelessWidget {
  HomeViewBody({super.key});
  WeatherEntity currentWeatherEntity = WeatherEntity.init();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BlocProvider.of<HomeViewCubit>(context).getCurrentWeather();
    });

    return BlocConsumer<HomeViewCubit, HomeViewState>(
      listener: (context, state) {
        if (state is HomeViewFailed) {
          showSnackBar(context, state.error.message);
        } else if (state is HomeViewSuccess) {
          currentWeatherEntity = state.currentWeatherEntity;
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
                            await BlocProvider.of<HomeViewCubit>(context).getCurrentWeather();
                          } else {
                            DateTime date = DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              DateTime.now().hour,
                            );
                            await BlocProvider.of<HomeViewCubit>(context).getForcastWeather(date);
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      WeartherStatistics(currentWeatherEntity: currentWeatherEntity),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () async {
                                var res = await getit.get<GetPredictionUseCase>().getPrediction();
                                print(res);
                              },
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
