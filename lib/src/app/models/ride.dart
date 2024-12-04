class Ride {
  final String id;
  final String userId;
  final String? driverId;
  final String pickupLocation;
  final String dropoffLocation;
  final DateTime requestTime;
  final DateTime pickupTime;
  final RideStatus status;
  final double? fare;

  Ride({
    required this.id,
    required this.userId,
    this.driverId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.requestTime,
    required this.pickupTime,
    this.status = RideStatus.pending,
    this.fare,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'] as String,
      userId: json['userId'] as String,
      driverId: json['driverId'] as String?,
      pickupLocation: json['pickupLocation'] as String,
      dropoffLocation: json['dropoffLocation'] as String,
      requestTime: DateTime.parse(json['requestTime'] as String),
      pickupTime: DateTime.parse(json['pickupTime'] as String),
      status: RideStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => RideStatus.pending,
      ),
      fare: json['fare'] as double?,
    );
  }
}

enum RideStatus { pending, accepted, inProgress, completed, cancelled }
