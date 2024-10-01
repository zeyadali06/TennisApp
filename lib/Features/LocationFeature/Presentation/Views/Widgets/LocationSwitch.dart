import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/MyLocationCubit/my_location_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/LocationSwitch/location_switch_cubit.dart';

class LocationSwitch extends StatefulWidget {
  const LocationSwitch({super.key});

  @override
  State<LocationSwitch> createState() => _LocationSwitchState();
}

class _LocationSwitchState extends State<LocationSwitch> {
  late bool open;

  @override
  void initState() {
    open = false;
    getStatus();
    super.initState();
  }

  Future getStatus() async {
    open = await BlocProvider.of<MyLocationCubit>(context).checkLocationStatus();
    BlocProvider.of<LocationSwitchCubit>(context).locationStatus(open);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationSwitchCubit, LocationSwitchState>(
      listener: (context, state) {
        if (state is UpdateSwitchStatus) {
          open = state.status;
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Location',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
            ),
            Switch(
              value: open,
              activeTrackColor: const Color(0xff014bb4),
              onChanged: (value) async {
                bool locationStatus = BlocProvider.of<MyLocationCubit>(context).permEnabled;

                if (value && locationStatus) {
                  open = true;
                } else if (value && !locationStatus) {
                  await BlocProvider.of<MyLocationCubit>(context).openLocationSettings();
                } else if (!value && locationStatus) {
                  open = false;
                } else {
                  open = false;
                }

                setState(() {});
              },
            )
          ],
        );
      },
    );
  }
}
