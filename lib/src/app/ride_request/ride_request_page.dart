import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/auth_service.dart';

class RideRequestPage extends StatefulWidget {
  const RideRequestPage({super.key});

  @override
  State<RideRequestPage> createState() => _RideRequestPageState();
}

class _RideRequestPageState extends State<RideRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _pickupController = TextEditingController();
  final _dropoffController = TextEditingController();
  DateTime? _pickupTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request a Ride')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _pickupController,
                decoration: const InputDecoration(labelText: 'Pickup Location'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required field' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dropoffController,
                decoration:
                    const InputDecoration(labelText: 'Dropoff Location'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required field' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    final now = DateTime.now();
                    setState(() {
                      _pickupTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                },
                child: Text(_pickupTime == null
                    ? 'Select Pickup Time'
                    : 'Pickup at: ${_pickupTime.toString()}'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitRequest,
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate() || _pickupTime == null) {
      return;
    }

    final userId = context.read<AuthService>().currentUser?.id;
    if (userId == null) return;

    try {
      await context.read<RideService>().createRide(
            userId: userId,
            pickupLocation: _pickupController.text,
            dropoffLocation: _dropoffController.text,
            pickupTime: _pickupTime!,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride request submitted successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }
}
