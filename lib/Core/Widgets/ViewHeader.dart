import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Utils/Constants.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';
import 'package:tennis_app/Features/NavigationBar/Presentation/Controllers/NavigationBarCubit/navigation_bar_cubit.dart';

class ViewHeader extends StatelessWidget {
  const ViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FittedWidget(
              child: Text(
                'Hello',
                style: TextStyle(
                  color: Color(0xff0053bd),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FittedWidget(
              child: Text(
                Constants.userModel.fullName.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () async {
            final bool? shouldLogout = await showDialog<bool>(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  backgroundColor: const Color(0xff051642),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(dialogContext, false);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    CustomButton(
                      title: 'Logout',
                      fontSize: 14,
                      onPressed: () {
                        Navigator.pop(dialogContext, true);
                      },
                    ),
                  ],
                );
              },
            );

            if (shouldLogout == true && context.mounted) {
              BlocProvider.of<NavigationBarCubit>(context).logout();
            }
          },
          icon: Transform.rotate(
            angle: -math.pi / 2.0,
            child: const Icon(
              Icons.file_download_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
