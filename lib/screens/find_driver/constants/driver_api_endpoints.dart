/// Endpoints خاصة بـ Find Driver
/// الـ Base URL جاي من configs.dart (BASE_URL = DOMAIN_URL + /api/)
/// الرابط النهائي = BASE_URL + الـ endpoint اللي تحت

class DriverApiEndpoints {
  DriverApiEndpoints._();

  /// البحث عن سائقين قريبين
  /// POST – body: { latitude, longitude, radius? }
  static const String findDrivers = 'find-drivers';

  /// طلب سائق (بعد ما اليوزر يختار سائق)
  /// POST – body: { driver_id, latitude, longitude } أو { booking_id, pickup_latitude, ... }
  static const String requestDriver = 'request-driver';

  /// حالة طلب السائق (للتتبع)
  /// GET – query: booking_id
  static String driverBookingStatus(int bookingId) =>
      'driver-booking-status?booking_id=$bookingId';

  /// إلغاء طلب السائق
  /// POST – body: { booking_id }
  static const String cancelDriverRequest = 'cancel-driver-request';

  /// تحديث موقع السائق (من تطبيق السائق)
  /// POST – body: { driver_booking_id, latitude, longitude }
  static const String updateDriverLocation = 'update-driver-location';
}
