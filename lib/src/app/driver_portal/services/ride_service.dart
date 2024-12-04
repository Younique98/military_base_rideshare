import '../../models/ride.dart';

class RideService {
  // Get all available rides that haven't been accepted by a driver
  Future<List<Ride>> getAvailableRides() async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock data for testing
    return [
      Ride(
        id: '1',
        userId: 'user1',
        pickupLocation: 'Main Gate',
        dropoffLocation: 'Base Housing',
        requestTime: DateTime.now(),
        pickupTime: DateTime.now().add(const Duration(minutes: 30)),
        status: RideStatus.pending,
      ),
      Ride(
        id: '2',
        userId: 'user2',
        pickupLocation: 'PX',
        dropoffLocation: 'Barracks',
        requestTime: DateTime.now(),
        pickupTime: DateTime.now().add(const Duration(hours: 1)),
        status: RideStatus.pending,
      ),
    ];
  }

  // Get rides associated with a specific driver
  Future<List<Ride>> getDriverRides(String driverId) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock data for testing
    return [
      Ride(
        id: '3',
        userId: 'user3',
        driverId: driverId,
        pickupLocation: 'Commissary',
        dropoffLocation: 'Gym',
        requestTime: DateTime.now().subtract(const Duration(hours: 1)),
        pickupTime: DateTime.now().add(const Duration(minutes: 15)),
        status: RideStatus.accepted,
      ),
      Ride(
        id: '4',
        userId: 'user4',
        driverId: driverId,
        pickupLocation: 'Medical Center',
        dropoffLocation: 'Base Housing',
        requestTime: DateTime.now().subtract(const Duration(hours: 2)),
        pickupTime: DateTime.now(),
        status: RideStatus.inProgress,
      ),
    ];
  }

  // Get rides requested by a specific user
  Future<List<Ride>> getUserRides(String userId) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));

    return [
      Ride(
        id: '5',
        userId: userId,
        pickupLocation: 'Base Housing',
        dropoffLocation: 'Main Gate',
        requestTime: DateTime.now().subtract(const Duration(days: 1)),
        pickupTime: DateTime.now().subtract(const Duration(hours: 23)),
        status: RideStatus.completed,
      ),
    ];
  }

  // Create a new ride request
  Future<Ride> createRide({
    required String userId,
    required String pickupLocation,
    required String dropoffLocation,
    required DateTime pickupTime,
  }) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));

    return Ride(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      pickupLocation: pickupLocation,
      dropoffLocation: dropoffLocation,
      requestTime: DateTime.now(),
      pickupTime: pickupTime,
      status: RideStatus.pending,
    );
  }

  // Update the status of a ride
  Future<void> updateRideStatus(String rideId, RideStatus status) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));

    // In a real implementation, this would update the ride status in the backend
  }

  // Cancel a ride
  Future<void> cancelRide(String rideId) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));

    await updateRideStatus(rideId, RideStatus.cancelled);
  }
}
