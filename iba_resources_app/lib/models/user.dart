import 'package:iba_resources_app/models/resource.dart';

class User {
  const User({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.postedResources,
    required this.savedResources,
    required this.points,
    required this.reportCount,
    required this.isBanned,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String role;
  final String name;
  final String email;
  final String password;
  final List<Resource>? postedResources;
  final List<Resource>? savedResources;
  final int? points;
  final int? reportCount;
  final bool? isBanned;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isDeleted;
}
