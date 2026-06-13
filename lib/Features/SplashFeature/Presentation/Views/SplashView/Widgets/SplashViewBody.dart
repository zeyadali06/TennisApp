import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Features/SplashFeature/Presentation/Controllers/cubit/splash_view_cubit.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashViewCubit, SplashViewState>(
      listener: (context, state) {
        if (state is SplashViewSuccess) {
          Navigator.pushReplacement(
              context, AppRouter.getRoute(context, AppRouter.navigationBar));
        } else if (state is SplashViewFailed) {
          Navigator.pushReplacement(
              context, AppRouter.getRoute(context, AppRouter.authOptions));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SplashViewLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child:
                  Lottie.asset("assets/images/CNKQNaQVuG.json", repeat: true),
            ),
          ),
        );
      },
    );
  }
}
