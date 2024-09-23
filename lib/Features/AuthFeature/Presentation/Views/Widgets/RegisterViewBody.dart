import 'package:flutter/material.dart';
import 'package:weather_app/Core/Utils/AppRouter.dart';
import 'package:weather_app/Core/Widgets/CustomButton.dart';
import 'package:weather_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:weather_app/Core/Widgets/ScaleDown.dart';
import 'package:weather_app/Features/AuthFeature/Data/Models/RegisterModel.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/Widgets/AuthViewHeader.dart';
import 'package:weather_app/Features/AuthFeature/Presentation/Views/Widgets/InputDataSection.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey();
  final RegisterModel registerModel = RegisterModel();
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
              const AuthViewHeader(title: 'SIGN UP', subTitle: 'CREATE AN ACCOUNT TO MAKE SDFSDF'),
              const Expanded(flex: 3, child: SizedBox()),
              InputDataSection(
                title: 'FULL NAME',
                onChanged: (value) => registerModel.fullName = value,
              ),
              const SizedBox(height: 10),
              InputDataSection(
                title: 'Email',
                onChanged: (value) => registerModel.email = value,
              ),
              const SizedBox(height: 10),
              InputDataSection(
                title: 'Password',
                onChanged: (value) => password = value!,
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
                        title: 'NEXT',
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
                        Navigator.pushReplacement(context, AppRouter.goTo(context, AppRouter.loginView));
                      },
                      child: const Text(
                        "HAVE AN ACCOUNT ?",
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
