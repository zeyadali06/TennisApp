import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tennis_app/Core/Formatters/Formatters.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Core/Widgets/ScaleDown.dart';
import 'package:tennis_app/Core/Widgets/SnackBar.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/RegisterEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/RegisterCubit/register_cubit.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/Widgets/AuthViewHeader.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/Widgets/InputDataSection.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  late final AutovalidateMode autovalidateMode;
  late final GlobalKey<FormState> formKey;
  late final RegisterEntity registerEntity;
  late String password;
  late bool isLoading;

  @override
  void initState() {
    registerEntity = RegisterEntity();
    autovalidateMode = AutovalidateMode.disabled;
    formKey = GlobalKey();
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
          return;
        } else if (state is RegisterFailed) {
          showSnackBar(context, state.error.message);
        } else if (state is RegisterSuccess) {
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
                          const AuthViewHeader(title: 'SIGN UP', subTitle: 'CREATE AN ACCOUNT TO MAKE SDFSDF'),
                          const Expanded(flex: 3, child: SizedBox(height: 50)),
                          InputDataSection(
                            title: 'FULL NAME',
                            onSaved: (value) => registerEntity.fullName = value,
                            inputFormatters: [Formatters.lettersOnly],
                          ),
                          const SizedBox(height: 10),
                          InputDataSection(
                            title: 'Email',
                            onSaved: (value) => registerEntity.email = value,
                            inputFormatters: [Formatters.preventSpaces, Formatters.emailRegExp],
                          ),
                          const SizedBox(height: 10),
                          InputDataSection(
                            title: 'Password',
                            onSaved: (value) => password = value!,
                          ),
                          const Expanded(flex: 1, child: SizedBox(height: 10)),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: CustomButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        await BlocProvider.of<RegisterCubit>(context).register(registerEntity, password);
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
