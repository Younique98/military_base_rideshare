import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final user = authService.currentUser;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Military Ride Share'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authService.signOut(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.name}!'),
            const SizedBox(height: 20),
            if (user.isDriver)
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/driver-portal'),
                child: const Text('Go to Driver Portal'),
              )
            else
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/ride-request'),
                child: const Text('Request a Ride'),
              ),
          ],
        ),
      ),
    );
  }
}
