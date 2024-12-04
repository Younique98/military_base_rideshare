import 'package:flutter/material.dart';
import 'src/app/authentication/sign_in_page.dart';
import 'src/app/authentication/sign_up_page.dart';
import 'src/app/home/home_page.dart';
import 'src/app/ride_request/ride_request_page.dart';
import 'src/app/driver_portal/driver_portal_page.dart';
import 'src/app/customer_dashboard/customer_dashboard_page.dart';

class AppRouter {
  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String rideRequest = '/ride-request';
  static const String driverPortal = '/driver-portal';
  static const String customerDashboard = '/customer-dashboard';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case rideRequest:
        return MaterialPageRoute(builder: (_) => const RideRequestPage());
      case driverPortal:
        return MaterialPageRoute(builder: (_) => const DriverPortalPage());
      case customerDashboard:
        return MaterialPageRoute(builder: (_) => const CustomerDashboardPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
