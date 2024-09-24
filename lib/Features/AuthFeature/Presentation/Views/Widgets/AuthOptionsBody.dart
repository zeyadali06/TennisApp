import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';

class AuthOptionsBody extends StatelessWidget {
  const AuthOptionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(color: Colors.white),
            child: Lottie.asset("assets/images/CNKQNaQVuG.json", repeat: true),
          ),
        ),
        Expanded(
          child: CustomGradiantContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, AppRouter.goTo(context, AppRouter.registerView));
                              },
                              title: 'Sign In',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, AppRouter.goTo(context, AppRouter.loginView));
                              },
                              title: 'Log In',
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
