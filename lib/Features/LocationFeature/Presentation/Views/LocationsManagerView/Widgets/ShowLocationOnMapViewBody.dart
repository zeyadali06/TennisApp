import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowLocationOnMapViewBody extends StatefulWidget {
  const ShowLocationOnMapViewBody({super.key, required this.coordinates});

  final LatLng coordinates;

  @override
  State<ShowLocationOnMapViewBody> createState() =>
      _ShowLocationOnMapViewBodyState();
}

class _ShowLocationOnMapViewBodyState extends State<ShowLocationOnMapViewBody> {
  late final GoogleMapController? _mapController;
  late String _selectedAddress;

  @override
  void initState() {
    _selectedAddress = "Move the map to choose a location";
    super.initState();
  }

  @override
  void dispose() {
    _mapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          padding: const EdgeInsets.only(bottom: 100),
          initialCameraPosition: CameraPosition(
            target: widget.coordinates,
            zoom: 13.5,
          ),
          scrollGesturesEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          myLocationEnabled: false,
          onMapCreated: (controller) {
            _mapController = controller;
          },
          onCameraIdle: () async {
            try {
              final placemarks = await placemarkFromCoordinates(
                widget.coordinates.latitude,
                widget.coordinates.longitude,
              );

              if (placemarks.isNotEmpty) {
                final place = placemarks.first;

                setState(() {
                  _selectedAddress =
                      "${place.street}, ${place.locality}, ${place.country}";
                });
              }
            } catch (e) {
              setState(() {
                _selectedAddress = "Unable to get address";
              });
            }
          },
        ),
        const Center(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 50,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedAddress,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
