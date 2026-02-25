import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/driver_model.dart';

class FindDriverState {
  final bool isLoading;
  final List<DriverData> drivers;
  final Set<Marker> markers;
  final DriverData? selectedDriver;
  final LatLng? pickupLocation;
  final bool driverAccepted;
  final int? driverBookingId;

  const FindDriverState({
    this.isLoading = false,
    this.drivers = const [],
    this.markers = const {},
    this.selectedDriver,
    this.pickupLocation,
    this.driverAccepted = false,
    this.driverBookingId,
  });

  FindDriverState copyWith({
    bool? isLoading,
    List<DriverData>? drivers,
    Set<Marker>? markers,
    DriverData? selectedDriver,
    LatLng? pickupLocation,
    bool? driverAccepted,
    int? driverBookingId,
  }) {
    return FindDriverState(
      isLoading: isLoading ?? this.isLoading,
      drivers: drivers ?? this.drivers,
      markers: markers ?? this.markers,
      selectedDriver: selectedDriver ?? this.selectedDriver,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      driverAccepted: driverAccepted ?? this.driverAccepted,
      driverBookingId: driverBookingId ?? this.driverBookingId,
    );
  }
}
