import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:military_base_rideshare/src/app/models/ride.dart';
import 'package:military_base_rideshare/widgets/ride_card.dart';

void main() {
  testWidgets('RideCard displays ride information',
      (WidgetTester tester) async {
    final ride = Ride(
      id: '1',
      userId: 'user1',
      pickupLocation: 'Main Gate',
      dropoffLocation: 'Base Housing',
      requestTime: DateTime.now(),
      pickupTime: DateTime.now().add(const Duration(minutes: 30)),
      status: RideStatus.pending,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RideCard(
            ride: ride,
            onAccept: () {},
          ),
        ),
      ),
    );

    expect(find.text('Pickup: Main Gate'), findsOneWidget);
    expect(find.text('Dropoff: Base Housing'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('RideCard calls onAccept when accept button is pressed',
      (WidgetTester tester) async {
    bool acceptPressed = false;

    final ride = Ride(
      id: '1',
      userId: 'user1',
      pickupLocation: 'Main Gate',
      dropoffLocation: 'Base Housing',
      requestTime: DateTime.now(),
      pickupTime: DateTime.now().add(const Duration(minutes: 30)),
      status: RideStatus.pending,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RideCard(
            ride: ride,
            onAccept: () => acceptPressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    expect(acceptPressed, isTrue);
  });
}
