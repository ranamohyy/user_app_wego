import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/driver_service.dart';
import 'track_driver_state.dart';

class TrackDriverCubit extends Cubit<TrackDriverState> {
  TrackDriverCubit({required this.bookingId}) : super(const TrackDriverState());

  final int bookingId;
  Timer? _timer;

  void startTracking() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      try {
        final response = await DriverService.getDriverBookingStatus(
          bookingId: bookingId,
        );
        if (response.booking != null) {
          final status = response.booking!.status ?? 'requested';
          LatLng? driverLocation;
          if (response.booking!.driverLatitude != null &&
              response.booking!.driverLongitude != null) {
            driverLocation = LatLng(
              response.booking!.driverLatitude!,
              response.booking!.driverLongitude!,
            );
          }
          emit(state.copyWith(status: status, driverLocation: driverLocation));
        }
      } catch (_) {}
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
