import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Widgets/ScaleDown.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Core/Formatters/Formatters.dart';
import 'package:tennis_app/Core/Widgets/InputDataSection.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/CommonWidgets/AuthViewHeader.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/LoginCubit/login_cubit.dart';

// ignore: must_be_immutable
class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final AutovalidateMode autovalidateMode = AutovalidateMode.always;
  final GlobalKey<FormState> formKey = GlobalKey();
  final LoginEntity loginEntity = LoginEntity();
  late String password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
          return;
        } else if (state is LoginFailed) {
          showSnackBar(context, state.error.message);
        } else if (state is LoginSuccess) {
          Navigator.pushReplacement(context, AppRouter.goTo(context, AppRouter.navigationBar));
        }
        isLoading = false;
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: formKey,
                  autovalidateMode: autovalidateMode,
                  child: CustomGradiantContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          const Expanded(flex: 3, child: SizedBox(height: 50)),
                          const AuthViewHeader(title: 'LOGIN', subTitle: 'CREATE AN ACCOUNT TO MAKE SDFSDF'),
                          const Expanded(flex: 3, child: SizedBox(height: 50)),
                          InputDataSection(
                            title: 'Email',
                            inputFormatters: [Formatters.preventSpaces, Formatters.emailRegExp],
                            onSaved: (value) => loginEntity.email = value,
                          ),
                          const SizedBox(height: 10),
                          InputDataSection(
                            title: 'Password',
                            onSaved: (value) => password = value!,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ScaleDown(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, AppRouter.goTo(context, AppRouter.forgetPasswordView));
                                  },
                                  child: const Text(
                                    'Forget your password?',
                                    style: TextStyle(color: Color(0xff1b3b8e), fontSize: 10, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const Expanded(flex: 1, child: SizedBox(height: 20)),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: CustomButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        await BlocProvider.of<LoginCubit>(context).login(loginEntity, password);
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
