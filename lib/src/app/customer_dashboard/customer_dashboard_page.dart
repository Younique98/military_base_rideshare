import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ride.dart';
import '../authentication/auth_service.dart';
import '../widgets/ride_history_card.dart';

class CustomerDashboardPage extends StatelessWidget {
  const CustomerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthService>().currentUser?.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rides'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/ride-request'),
          ),
        ],
      ),
      body: userId == null
          ? const Center(child: Text('Please sign in'))
          : FutureBuilder<List<Ride>>(
              future: context.read<RideService>().getUserRides(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final rides = snapshot.data ?? [];
                if (rides.isEmpty) {
                  return const Center(
                    child: Text('No ride history. Request your first ride!'),
                  );
                }

                return ListView.builder(
                  itemCount: rides.length,
                  itemBuilder: (context, index) => RideHistoryCard(
                    ride: rides[index],
                    onCancel: () => _cancelRide(context, rides[index]),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _cancelRide(BuildContext context, Ride ride) async {
    try {
      await context.read<RideService>().updateRideStatus(
            ride.id,
            RideStatus.cancelled,
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride cancelled successfully')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }
}
