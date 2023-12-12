import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_resources_app/models/resource.dart';

class UserModel {
  const UserModel({
    required this.userId,
    required this.role,
    required this.name,
    required this.email,
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

  final String userId;
  final String role;
  final String name;
  final String email;

  final List<ResourceModel>? postedResources;
  final List<ResourceModel>? savedResources;
  final int points;
  final int? reportCount;
  final bool? isBanned;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;

  factory UserModel.fromJson(Map<String, dynamic> userData) {
    return UserModel(
      userId: userData['userId'],
      role: userData['role'],
      name: userData['name'],
      email: userData['email'],
      postedResources: (userData['postedResources'] as List<dynamic>?)
          ?.map((resourceData) => ResourceModel.fromJson(resourceData))
          .toList(),
      savedResources: (userData['savedResources'] as List<dynamic>?)
          ?.map((resourceData) => ResourceModel.fromJson(resourceData))
          .toList(),
      points: userData['points'],
      reportCount: userData['reportCount'],
      isBanned: userData['isBanned'],
      isActive: userData['isActive'],
      isDeleted: userData['isDeleted'],
      createdAt: (userData['createdAt'] as Timestamp).toDate(),
      updatedAt: (userData['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'role': role,
      'name': name,
      'email': email,
      'postedResources':
          postedResources?.map((resource) => resource.toMap()).toList(),
      'savedResources':
          savedResources?.map((resource) => resource.toMap()).toList(),
      'points': points,
      'reportCount': reportCount,
      'isBanned': isBanned,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  UserModel copyWith({
    String? userId,
    String? role,
    String? name,
    String? email,
    List<ResourceModel>? postedResources,
    List<ResourceModel>? savedResources,
    int? points,
    int? reportCount,
    bool? isBanned,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isDeleted,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      name: name ?? this.name,
      email: email ?? this.email,
      postedResources: postedResources ?? this.postedResources,
      savedResources: savedResources ?? this.savedResources,
      points: points ?? this.points,
      reportCount: reportCount ?? this.reportCount,
      isBanned: isBanned ?? this.isBanned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
