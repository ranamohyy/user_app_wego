import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../models/driver_model.dart';
import '../services/driver_service.dart';
import 'find_driver_state.dart';

class FindDriverCubit extends Cubit<FindDriverState> {
  FindDriverCubit() : super(const FindDriverState());

  Timer? _statusTimer;

  Future<void> initialize() async {
    emit(state.copyWith(isLoading: true));

    try {
      final position = await Geolocator.getCurrentPosition();
      final pickupLocation = LatLng(position.latitude, position.longitude);
      emit(state.copyWith(pickupLocation: pickupLocation));
      await searchDrivers();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> searchDrivers() async {
    if (state.pickupLocation == null) return;

    try {
      final response = await DriverService.searchDrivers(
        latitude: state.pickupLocation!.latitude,
        longitude: state.pickupLocation!.longitude,
      );

      final drivers = response.driverList ?? [];
      final markers = _buildMarkers(drivers);
      emit(state.copyWith(drivers: drivers, markers: markers));
    } catch (_) {
      emit(state.copyWith(drivers: []));
    }
  }

  Set<Marker> _buildMarkers(List<DriverData> drivers) {
    final Set<Marker> markers = {};
    if (state.pickupLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: state.pickupLocation!,
        ),
      );
    }
    for (var driver in drivers) {
      if (driver.latitude != null && driver.longitude != null) {
        markers.add(
          Marker(
            markerId: MarkerId('driver_${driver.id}'),
            position: LatLng(driver.latitude!, driver.longitude!),
          ),
        );
      }
    }
    return markers;
  }

  Future<void> selectDriver(DriverData driver) async {
    if (state.pickupLocation == null) return;

    emit(state.copyWith(selectedDriver: driver));

    try {
      final response = await DriverService.sendDriverRequest(
        driverId: driver.id!,
        latitude: state.pickupLocation!.latitude,
        longitude: state.pickupLocation!.longitude,
      );

      final bookingId = response.booking?.id;
      if (bookingId != null) {
        emit(state.copyWith(driverBookingId: bookingId));
        _startCheckingAcceptance(bookingId);
      }
    } catch (_) {}
  }

  void _startCheckingAcceptance(int bookingId) {
    _statusTimer?.cancel();
    _statusTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final status = await DriverService.checkDriverAcceptance(
        bookingId: bookingId,
      );
      if (status == 'accepted') {
        timer.cancel();
        emit(state.copyWith(driverAccepted: true));
      }
    });
  }

  @override
  Future<void> close() {
    _statusTimer?.cancel();
    return super.close();
  }
}
