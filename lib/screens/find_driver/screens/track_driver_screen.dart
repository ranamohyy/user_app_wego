import 'package:booking_system_flutter/screens/find_driver/cubit/track_driver_cubit.dart';
import 'package:booking_system_flutter/screens/find_driver/cubit/track_driver_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackDriverScreen extends StatelessWidget {
  final int bookingId;
  final LatLng pickupLocation;

  const TrackDriverScreen({
    super.key,
    required this.bookingId,
    required this.pickupLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Driver')),
      body: BlocBuilder<TrackDriverCubit, TrackDriverState>(
        builder: (context, state) {
          final markers = <Marker>{
            Marker(
              markerId: const MarkerId('pickup'),
              position: pickupLocation,
            ),
          };
          if (state.driverLocation != null) {
            markers.add(
              Marker(
                markerId: const MarkerId('driver'),
                position: state.driverLocation!,
              ),
            );
          }
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: pickupLocation,
              zoom: 14,
            ),
            markers: markers,
            myLocationEnabled: true,
          );
        },
      ),
    );
  }
}
