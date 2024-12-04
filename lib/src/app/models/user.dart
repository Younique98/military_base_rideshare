class User {
  final String id;
  final String email;
  final String name;
  final bool isDriver;
  final String? militaryId;
  final String? baseAssignment;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.isDriver = false,
    this.militaryId,
    this.baseAssignment,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      isDriver: json['isDriver'] as bool? ?? false,
      militaryId: json['militaryId'] as String?,
      baseAssignment: json['baseAssignment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'isDriver': isDriver,
      'militaryId': militaryId,
      'baseAssignment': baseAssignment,
    };
  }
}
