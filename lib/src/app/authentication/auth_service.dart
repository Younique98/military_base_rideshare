import 'package:flutter/foundation.dart';
import '../models/user.dart';
import 'auth_repository.dart';
import '../models/ride.dart';

class AuthService extends ChangeNotifier {
  final AuthRepository _repository;
  User? _currentUser;

  AuthService({AuthRepository? repository})
      : _repository = repository ?? AuthRepository();

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<void> signIn(String email, String password) async {
    _currentUser = await _repository.signIn(email, password);
    notifyListeners();
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String militaryId,
    required String baseAssignment,
    bool isDriver = false,
  }) async {
    _currentUser = await _repository.signUp(
      email: email,
      password: password,
      name: name,
      militaryId: militaryId,
      baseAssignment: baseAssignment,
      isDriver: isDriver,
    );
    notifyListeners();
  }

  Future<void> signOut() async {
    await _repository.signOut();
    _currentUser = null;
    notifyListeners();
  }
}

class RideService {
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
    );
  }

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
    ];
  }

  // Add this method - Get rides for a specific driver
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

  Future<List<Ride>> getUserRides(String userId) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));

    return []; // Return mock data as needed
  }

  Future<void> updateRideStatus(String rideId, RideStatus status) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
  }
}
