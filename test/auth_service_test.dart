import 'package:flutter_test/flutter_test.dart';
import 'package:military_base_rideshare/src/app/authentication/auth_service.dart';

void main() {
  late AuthService authService;

  setUp(() {
    authService = AuthService();
  });

  group('AuthService', () {
    test('should start with null user', () {
      expect(authService.currentUser, isNull);
      expect(authService.isAuthenticated, isFalse);
    });

    test('should authenticate user on sign in', () async {
      await authService.signIn('test@military.com', 'password123');

      expect(authService.currentUser, isNotNull);
      expect(authService.isAuthenticated, isTrue);
      expect(authService.currentUser?.email, equals('test@military.com'));
    });

    test('should clear user on sign out', () async {
      // First sign in
      await authService.signIn('test@military.com', 'password123');
      expect(authService.isAuthenticated, isTrue);

      // Then sign out
      await authService.signOut();
      expect(authService.currentUser, isNull);
      expect(authService.isAuthenticated, isFalse);
    });

    test('should create new user on sign up', () async {
      await authService.signUp(
        email: 'new@military.com',
        password: 'password123',
        name: 'John Doe',
        militaryId: '12345',
        baseAssignment: 'Fort Test',
        isDriver: true,
      );

      expect(authService.currentUser, isNotNull);
      expect(authService.currentUser?.email, equals('new@military.com'));
      expect(authService.currentUser?.name, equals('John Doe'));
      expect(authService.currentUser?.isDriver, isTrue);
    });
  });
}
