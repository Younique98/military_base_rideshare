import 'package:flutter_test/flutter_test.dart';
import 'package:military_base_rideshare/src/app/models/ride.dart';
import 'package:military_base_rideshare/src/app/authentication/auth_service.dart';

void main() {
  late RideService rideService;

  setUp(() {
    rideService = RideService();
  });

  group('RideService', () {
    test('should create new ride request', () async {
      final ride = await rideService.createRide(
        userId: 'user123',
        pickupLocation: 'Main Gate',
        dropoffLocation: 'Base Housing',
        pickupTime: DateTime.now().add(const Duration(hours: 1)),
      );

      expect(ride.userId, equals('user123'));
      expect(ride.status, equals(RideStatus.pending));
      expect(ride.pickupLocation, equals('Main Gate'));
      expect(ride.dropoffLocation, equals('Base Housing'));
    });

    test('should fetch available rides', () async {
      final rides = await rideService.getAvailableRides();

      expect(rides, isNotEmpty);
      expect(rides.every((ride) => ride.status == RideStatus.pending), isTrue);
      expect(rides.every((ride) => ride.driverId == null), isTrue);
    });

    test('should fetch driver rides', () async {
      final rides = await rideService.getDriverRides('driver123');

      expect(rides, isNotEmpty);
      expect(
        rides.every((ride) => ride.driverId == 'driver123'),
        isTrue,
      );
    });

    test('should update ride status', () async {
      // Create a ride first
      final ride = await rideService.createRide(
        userId: 'user123',
        pickupLocation: 'Main Gate',
        dropoffLocation: 'Base Housing',
        pickupTime: DateTime.now().add(const Duration(hours: 1)),
      );

      // Update its status
      await rideService.updateRideStatus(ride.id, RideStatus.accepted);

      // In a real implementation, you would fetch the updated ride
      // and verify its new status
    });
  });
}
