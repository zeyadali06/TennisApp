import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/Widgets/AuthViewHeader.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Views/Widgets/InputDataSection.dart';
import 'package:tennis_app/Features/AuthFeature/Presentation/Controllers/ForgetPasswordCubit/forget_password_cubit.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  late final AutovalidateMode autovalidateMode;
  late final GlobalKey<FormState> formKey;
  late String email;
  late bool isLoading;

  @override
  void initState() {
    autovalidateMode = AutovalidateMode.disabled;
    formKey = GlobalKey();
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          isLoading = true;
          return;
        } else if (state is ForgetPasswordFailed) {
          showSnackBar(context, state.error.message);
        } else if (state is EmailSentSuccessfully) {
          showSnackBar(context, "Email sent successfully");
          Navigator.pushReplacement(context, AppRouter.goTo(context, AppRouter.loginView));
        }
        isLoading = false;
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: CustomGradiantContainer(
                child: ModalProgressHUD(
                  inAsyncCall: isLoading,
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                              )
                            ],
                          ),
                          const Expanded(flex: 2, child: SizedBox(height: 50)),
                          const AuthViewHeader(title: "RESET PASSWORD", subTitle: 'CREATE AN ACCOUNT TO MAKE SDFSDF'),
                          const Expanded(flex: 2, child: SizedBox(height: 50)),
                          InputDataSection(
                            title: "Email",
                            onSaved: (value) => email = value!,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Expanded(
                                child: CustomButton(
                                  title: "Submit",
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      await BlocProvider.of<ForgetPasswordCubit>(context).forgetPassword(email);
                                    } else {
                                      autovalidateMode = AutovalidateMode.always;
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                          const Expanded(flex: 1, child: SizedBox(height: 20)),
                          const Text(
                            'After Submit, We will sent you an email to enter your new password.',
                            style: TextStyle(color: Colors.white),
                          ),
                          const Expanded(flex: 3, child: SizedBox()),
                        ],
                      ),
                    ),
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
