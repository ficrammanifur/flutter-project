class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String membershipType;
  final int remainingClasses;
  final DateTime membershipExpiry;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.membershipType,
    required this.remainingClasses,
    required this.membershipExpiry,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      membershipType: json['membership_type'] ?? '',
      remainingClasses: json['remaining_classes'] ?? 0,
      membershipExpiry: DateTime.parse(json['membership_expiry'] ?? DateTime.now().toString()),
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'membership_type': membershipType,
      'remaining_classes': remainingClasses,
      'membership_expiry': membershipExpiry.toIso8601String(),
      'is_active': isActive,
    };
  }
}

class MembershipPackage {
  final String id;
  final String name;
  final int classes;
  final double price;
  final int validityDays;
  final String description;

  MembershipPackage({
    required this.id,
    required this.name,
    required this.classes,
    required this.price,
    required this.validityDays,
    required this.description,
  });

  factory MembershipPackage.fromJson(Map<String, dynamic> json) {
    return MembershipPackage(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      classes: json['classes'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      validityDays: json['validity_days'] ?? 0,
      description: json['description'] ?? '',
    );
  }
}

class ClassBooking {
  final String id;
  final String userId;
  final String className;
  final DateTime scheduledTime;
  final String status;
  final String instructor;

  ClassBooking({
    required this.id,
    required this.userId,
    required this.className,
    required this.scheduledTime,
    required this.status,
    required this.instructor,
  });

  factory ClassBooking.fromJson(Map<String, dynamic> json) {
    return ClassBooking(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      className: json['class_name'] ?? '',
      scheduledTime: DateTime.parse(json['scheduled_time'] ?? DateTime.now().toString()),
      status: json['status'] ?? '',
      instructor: json['instructor'] ?? '',
    );
  }
}
