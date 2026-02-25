import 'package:booking_system_flutter/model/base_response_model.dart';
import 'package:booking_system_flutter/network/network_utils.dart';
import 'package:booking_system_flutter/screens/find_driver/constants/driver_api_endpoints.dart';
import 'package:booking_system_flutter/screens/find_driver/models/driver_model.dart';
import 'package:nb_utils/nb_utils.dart';

class DriverService {
  /// Search for available drivers near pickup location
  static Future<DriverResponse> searchDrivers({
    required double latitude,
    required double longitude,
    double radius = 10.0, // km
  }) async {
    try {
      Map request = {
        'latitude': latitude,
        'longitude': longitude,
        'radius': radius,
      };

      var response = await handleResponse(
        await buildHttpResponse(
          DriverApiEndpoints.findDrivers,
          request: request,
          method: HttpMethodType.POST,
        ),
      );

      return DriverResponse.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }

  /// Request a driver for booking
  static Future<DriverBookingResponse> requestDriver({
    required DriverRequestModel requestModel,
  }) async {
    try {
      var response = await handleResponse(
        await buildHttpResponse(
          DriverApiEndpoints.requestDriver,
          request: requestModel.toJson(),
          method: HttpMethodType.POST,
        ),
      );

      return DriverBookingResponse.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }

  /// Get driver booking status
  static Future<DriverBookingResponse> getDriverBookingStatus({
    required int bookingId,
  }) async {
    try {
      var response = await handleResponse(
        await buildHttpResponse(
          DriverApiEndpoints.driverBookingStatus(bookingId),
          method: HttpMethodType.GET,
        ),
      );

      return DriverBookingResponse.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }

  /// Cancel driver request
  static Future<BaseResponseModel> cancelDriverRequest({
    required int bookingId,
  }) async {
    try {
      var response = await handleResponse(
        await buildHttpResponse(
          DriverApiEndpoints.cancelDriverRequest,
          request: {'booking_id': bookingId},
          method: HttpMethodType.POST,
        ),
      );

      return BaseResponseModel.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }

  /// Send driver request (when user selects a driver)
  static Future<DriverBookingResponse> sendDriverRequest({
    required int driverId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      var response = await handleResponse(
        await buildHttpResponse(
          DriverApiEndpoints.requestDriver,
          request: {
            'driver_id': driverId,
            'latitude': latitude,
            'longitude': longitude,
          },
          method: HttpMethodType.POST,
        ),
      );
      return DriverBookingResponse.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }

  /// Check if driver accepted the request (use bookingId from sendDriverRequest response)
  static Future<String?> checkDriverAcceptance({required int bookingId}) async {
    try {
      var response = await getDriverBookingStatus(bookingId: bookingId);
      return response.booking?.status;
    } catch (e) {
      return null;
    }
  }

  /// Update driver location (for tracking)
  static Future<void> updateDriverLocation({
    required int driverBookingId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await handleResponse(
        await buildHttpResponse(
          DriverApiEndpoints.updateDriverLocation,
          request: {
            'driver_booking_id': driverBookingId,
            'latitude': latitude,
            'longitude': longitude,
          },
          method: HttpMethodType.POST,
        ),
      );
    } catch (e) {
      // Silent fail for location updates
      log('Failed to update driver location: $e');
    }
  }
}
