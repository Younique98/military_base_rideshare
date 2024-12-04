import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(const MilitaryRideShareApp());
}

class MilitaryRideShareApp extends StatelessWidget {
  const MilitaryRideShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Military Ride Share',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.signIn,
    );
  }
}
