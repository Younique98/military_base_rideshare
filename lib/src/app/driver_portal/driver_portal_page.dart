import 'package:flutter/material.dart';
import 'package:military_base_rideshare/src/app/authentication/auth_service.dart';
import 'package:military_base_rideshare/widgets/ride_card.dart';
import 'package:provider/provider.dart';
import '../models/ride.dart';

class DriverPortalPage extends StatelessWidget {
  const DriverPortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Driver Portal'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Available Rides'),
              Tab(text: 'My Rides'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AvailableRidesTab(),
            MyRidesTab(),
          ],
        ),
      ),
    );
  }
}

class AvailableRidesTab extends StatelessWidget {
  const AvailableRidesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ride>>(
      future: context.read<RideService>().getAvailableRides(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final rides = snapshot.data ?? [];
        if (rides.isEmpty) {
          return const Center(child: Text('No available rides'));
        }

        return ListView.builder(
          itemCount: rides.length,
          itemBuilder: (context, index) => RideCard(
            ride: rides[index],
            onAccept: () => _acceptRide(context, rides[index]),
          ),
        );
      },
    );
  }

  Future<void> _acceptRide(BuildContext context, Ride ride) async {
    try {
      await context.read<RideService>().updateRideStatus(
            ride.id,
            RideStatus.accepted,
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride accepted successfully!')),
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

class MyRidesTab extends StatelessWidget {
  const MyRidesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final driverId = context.read<AuthService>().currentUser?.id;

    if (driverId == null) {
      return const Center(child: Text('Please sign in'));
    }

    return FutureBuilder<List<Ride>>(
      future: context.read<RideService>().getDriverRides(driverId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final rides = snapshot.data ?? [];
        if (rides.isEmpty) {
          return const Center(child: Text('No rides yet'));
        }

        return ListView.builder(
          itemCount: rides.length,
          itemBuilder: (context, index) => RideCard(
            ride: rides[index],
            onComplete: rides[index].status == RideStatus.inProgress
                ? () => _completeRide(context, rides[index])
                : null,
            onStart: rides[index].status == RideStatus.accepted
                ? () => _startRide(context, rides[index])
                : null,
          ),
        );
      },
    );
  }

  Future<void> _startRide(BuildContext context, Ride ride) async {
    try {
      await context.read<RideService>().updateRideStatus(
            ride.id,
            RideStatus.inProgress,
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride started successfully!')),
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

  Future<void> _completeRide(BuildContext context, Ride ride) async {
    try {
      await context.read<RideService>().updateRideStatus(
            ride.id,
            RideStatus.completed,
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride completed successfully!')),
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
