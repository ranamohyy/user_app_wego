class DriverResponse {
  List<DriverData>? driverList;
  bool? success;
  String? message;

  DriverResponse({this.driverList, this.success, this.message});

  factory DriverResponse.fromJson(Map<String, dynamic> json) {
    return DriverResponse(
      driverList: json['data'] != null
          ? (json['data'] as List).map((i) => DriverData.fromJson(i)).toList()
          : null,
      success: json['success'],
      message: json['message'],
    );
  }
}

class DriverData {
  int? id;
  String? name;
  String? email;
  String? contactNumber;
  String? profileImage;
  double? rating;
  int? totalRides;
  double? latitude;
  double? longitude;
  double? distance; // in km
  String? vehicleName;
  String? vehicleNumber;
  String? vehicleType;
  String? vehicleImage;
  bool? isAvailable;
  int? estimatedTime; // in minutes

  DriverData({
    this.id,
    this.name,
    this.email,
    this.contactNumber,
    this.profileImage,
    this.rating,
    this.totalRides,
    this.latitude,
    this.longitude,
    this.distance,
    this.vehicleName,
    this.vehicleNumber,
    this.vehicleType,
    this.vehicleImage,
    this.isAvailable,
    this.estimatedTime,
  });

  factory DriverData.fromJson(Map<String, dynamic> json) {
    return DriverData(
      id: json['id'],
      name: json['name'] ?? json['first_name'] ?? '',
      email: json['email'],
      contactNumber: json['contact_number'] ?? json['phone'] ?? '',
      profileImage: json['profile_image'] ?? json['avatar'] ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
      totalRides: json['total_rides'] ?? json['completed_rides'] ?? 0,
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      distance: json['distance']?.toDouble(),
      vehicleName: json['vehicle_name'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
      vehicleType: json['vehicle_type'] ?? 'Car',
      vehicleImage: json['vehicle_image'] ?? '',
      isAvailable: json['is_available'] ?? true,
      estimatedTime: json['estimated_time'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact_number': contactNumber,
      'profile_image': profileImage,
      'rating': rating,
      'total_rides': totalRides,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'vehicle_name': vehicleName,
      'vehicle_number': vehicleNumber,
      'vehicle_type': vehicleType,
      'vehicle_image': vehicleImage,
      'is_available': isAvailable,
      'estimated_time': estimatedTime,
    };
  }
}

class DriverRequestModel {
  int bookingId;
  double pickupLatitude;
  double pickupLongitude;
  double dropLatitude;
  double dropLongitude;
  String? pickupAddress;
  String? dropAddress;

  DriverRequestModel({
    required this.bookingId,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropLatitude,
    required this.dropLongitude,
    this.pickupAddress,
    this.dropAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'drop_latitude': dropLatitude,
      'drop_longitude': dropLongitude,
      'pickup_address': pickupAddress,
      'drop_address': dropAddress,
    };
  }
}

class DriverBookingResponse {
  bool? success;
  String? message;
  DriverBookingData? booking;

  DriverBookingResponse({this.success, this.message, this.booking});

  factory DriverBookingResponse.fromJson(Map<String, dynamic> json) {
    return DriverBookingResponse(
      success: json['success'],
      message: json['message'],
      booking: json['data'] != null
          ? DriverBookingData.fromJson(json['data'])
          : null,
    );
  }
}

class DriverBookingData {
  int? id;
  int? bookingId;
  int? driverId;
  String? status; // requested, accepted, arrived, started, completed, cancelled
  double? driverLatitude;
  double? driverLongitude;
  double? pickupLatitude;
  double? pickupLongitude;
  double? dropLatitude;
  double? dropLongitude;
  String? pickupAddress;
  String? dropAddress;
  DateTime? createdAt;
  DateTime? updatedAt;

  DriverBookingData({
    this.id,
    this.bookingId,
    this.driverId,
    this.status,
    this.driverLatitude,
    this.driverLongitude,
    this.pickupLatitude,
    this.pickupLongitude,
    this.dropLatitude,
    this.dropLongitude,
    this.pickupAddress,
    this.dropAddress,
    this.createdAt,
    this.updatedAt,
  });

  factory DriverBookingData.fromJson(Map<String, dynamic> json) {
    return DriverBookingData(
      id: json['id'],
      bookingId: json['booking_id'],
      driverId: json['driver_id'],
      status: json['status'],
      driverLatitude: json['driver_latitude']?.toDouble(),
      driverLongitude: json['driver_longitude']?.toDouble(),
      pickupLatitude: json['pickup_latitude']?.toDouble(),
      pickupLongitude: json['pickup_longitude']?.toDouble(),
      dropLatitude: json['drop_latitude']?.toDouble(),
      dropLongitude: json['drop_longitude']?.toDouble(),
      pickupAddress: json['pickup_address'],
      dropAddress: json['drop_address'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
