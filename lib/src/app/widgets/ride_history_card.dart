import 'package:flutter/material.dart';
import '../models/ride.dart';

class RideHistoryCard extends StatelessWidget {
  final Ride ride;
  final VoidCallback? onCancel;

  const RideHistoryCard({
    super.key,
    required this.ride,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pickup: ${ride.pickupLocation}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Dropoff: ${ride.dropoffLocation}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Time: ${ride.pickupTime.toString()}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${ride.status.toString().split('.').last}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _getStatusColor(ride.status),
                  ),
            ),
            if (ride.status == RideStatus.pending) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onCancel,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Cancel Ride'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(RideStatus status) {
    switch (status) {
      case RideStatus.pending:
        return Colors.orange;
      case RideStatus.accepted:
        return Colors.blue;
      case RideStatus.inProgress:
        return Colors.green;
      case RideStatus.completed:
        return Colors.green;
      case RideStatus.cancelled:
        return Colors.red;
    }
  }
}
