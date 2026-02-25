import 'package:booking_system_flutter/screens/find_driver/cubit/find_driver_cubit.dart';
import 'package:booking_system_flutter/screens/find_driver/cubit/find_driver_state.dart';
import 'package:booking_system_flutter/screens/find_driver/cubit/track_driver_cubit.dart';
import 'package:booking_system_flutter/screens/find_driver/screens/track_driver_screen.dart';
import 'package:booking_system_flutter/screens/find_driver/widgets/driver_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindDriverScreen extends StatelessWidget {
  const FindDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FindDriverCubit()..initialize(),
      child: const _FindDriverView(),
    );
  }
}

class _FindDriverView extends StatelessWidget {
  const _FindDriverView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindDriverCubit, FindDriverState>(
      listener: (context, state) {
        if (state.driverAccepted &&
            state.driverBookingId != null &&
            state.pickupLocation != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => TrackDriverCubit(bookingId: state.driverBookingId!)
                  ..startTracking(),
                child: TrackDriverScreen(
                  bookingId: state.driverBookingId!,
                  pickupLocation: state.pickupLocation!,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading || state.pickupLocation == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: state.pickupLocation!,
                  zoom: 14,
                ),
                markers: state.markers,
                myLocationEnabled: true,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  height: 300,
                  child: ListView.builder(
                    itemCount: state.drivers.length,
                    itemBuilder: (_, index) {
                      final driver = state.drivers[index];
                      return DriverCard(
                        driver: driver,
                        onSelect: () => context.read<FindDriverCubit>().selectDriver(driver),
                      );
                    },
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
