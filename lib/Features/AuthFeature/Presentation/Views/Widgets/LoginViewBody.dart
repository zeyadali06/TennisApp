import 'package:flutter/material.dart';
import 'package:weather_app/Core/Utils/AppRouter.dart';
import 'package:weather_app/Core/Widgets/CustomButton.dart';
import 'package:weather_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:weather_app/Core/Widgets/ScaleDown.dart';
import 'package:weather_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/Widgets/InputDataSection.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/Widgets/AuthViewHeader.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey();
  final LoginEntity loginModel = LoginEntity();
  late String password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: CustomGradiantContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              const AuthViewHeader(title: 'LOGIN', subTitle: 'CREATE AN ACCOUNT TO MAKE SDFSDF'),
              const Expanded(flex: 3, child: SizedBox()),
              InputDataSection(
                title: 'Email',
                onChanged: (value) => loginModel.email = value,
              ),
              const SizedBox(height: 10),
              InputDataSection(
                title: 'Password',
                onChanged: (value) => password = value!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ScaleDown(
                    child: GestureDetector(
                      child: const Text(
                        'Forget your password?',
                        style: TextStyle(color: Color(0xff1b3b8e), fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                        title: 'LOGIN',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleDown(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, AppRouter.goTo(context, AppRouter.registerView));
                      },
                      child: const Text(
                        "DON'T HAVE AN ACCOUNT ?",
                        style: TextStyle(color: Color(0xff1b3b8e), fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(flex: 3, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
