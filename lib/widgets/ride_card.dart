import 'package:flutter/material.dart';
import '../src/app/models/ride.dart';

class RideCard extends StatelessWidget {
  final Ride ride;
  final VoidCallback? onAccept;
  final VoidCallback? onComplete;
  final VoidCallback? onStart;
  final VoidCallback? onCancel;

  const RideCard({
    super.key,
    required this.ride,
    this.onAccept,
    this.onCancel,
    this.onComplete,
    this.onStart,
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onAccept != null)
                  ElevatedButton(
                    onPressed: onAccept,
                    child: const Text('Accept'),
                  ),
                if (onStart != null) ...[
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onStart,
                    child: const Text('Start Ride'),
                  ),
                ],
                if (onComplete != null) ...[
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onComplete,
                    child: const Text('Complete'),
                  ),
                ],
                if (onCancel != null) ...[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: onCancel,
                    child: const Text('Cancel'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
