import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

class MapViewBody extends StatefulWidget {
  const MapViewBody({super.key});

  @override
  State<MapViewBody> createState() => _MapViewBodyState();
}

class _MapViewBodyState extends State<MapViewBody> {
  late GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedAddress = "Move the map to choose a location";
  LatLng _selectedLocation = const LatLng(30.0444, 31.2357);
  late PositionEntity _positionEntity;

  @override
  void initState() {
    super.initState();
    _positionEntity = PositionEntity.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAddressFromLatLng();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            return Navigator.pop<PositionEntity>(context, _positionEntity);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Choose Location"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.satellite,
            padding: const EdgeInsets.only(top: 100, bottom: 150),
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 14,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onCameraMove: (position) {
              _selectedLocation = position.target;
            },
            onCameraIdle: () {
              _getAddressFromLatLng();
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _searchPlace(),
                decoration: InputDecoration(
                  hintText: "Search for place...",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchPlace,
                  ),
                ),
              ),
            ),
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
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            _positionEntity,
                          );
                        },
                        title: "Confirm Location",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        _selectedLocation.latitude,
        _selectedLocation.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;

        final String placeText =
            "${place.street ?? ""}, ${place.locality ?? ""}, ${place.country ?? ""}";

        setState(() {
          _selectedAddress = placeText;
        });

        _positionEntity = PositionEntity(
          place: placeText,
          latitude: _selectedLocation.latitude,
          longitude: _selectedLocation.longitude,
          isDefault: false,
        );
      }
    } catch (e) {
      try {
        setState(() {
          _selectedAddress = "Unable to get address";
        });
      } catch (_) {}
    }
  }

  Future<void> _searchPlace() async {
    if (_searchController.text.trim().isEmpty) return;

    try {
      final List<Location> locations =
          await locationFromAddress(_searchController.text.trim());

      if (locations.isNotEmpty) {
        final Location location = locations.first;

        final LatLng latLng = LatLng(
          location.latitude,
          location.longitude,
        );

        await _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(
            latLng,
            16,
          ),
        );

        setState(() {
          _selectedLocation = latLng;
        });

        _getAddressFromLatLng();
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, "Location not found");
      }
    }
  }
}
