import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackDriverState {
  final LatLng? driverLocation;
  final String status;

  const TrackDriverState({
    this.driverLocation,
    this.status = 'requested',
  });

  TrackDriverState copyWith({
    LatLng? driverLocation,
    String? status,
  }) {
    return TrackDriverState(
      driverLocation: driverLocation ?? this.driverLocation,
      status: status ?? this.status,
    );
  }
}
