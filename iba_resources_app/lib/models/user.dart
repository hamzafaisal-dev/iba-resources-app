import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_resources_app/models/resource.dart';

class UserModel {
  const UserModel({
    required this.userId,
    required this.role,
    required this.name,
    required this.email,
    required this.avatar,
    required this.postedResources,
    required this.savedResources,
    required this.likedResources,
    required this.dislikedResources,
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
  final String avatar;

  final List<ResourceModel>? postedResources;
  final List<ResourceModel>? savedResources;
  final List<ResourceModel>? likedResources;
  final List<ResourceModel>? dislikedResources;
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
      avatar: userData['avatar'],
      postedResources: (userData['postedResources'] as List<dynamic>?)
          ?.map((resourceData) => ResourceModel.fromJson(resourceData))
          .toList(),
      savedResources: (userData['savedResources'] as List<dynamic>?)
          ?.map((resourceData) => ResourceModel.fromJson(resourceData))
          .toList(),
      likedResources: (userData['likedResources'] as List<dynamic>?)
          ?.map((resourceData) => ResourceModel.fromJson(resourceData))
          .toList(),
      dislikedResources: (userData['dislikedResources'] as List<dynamic>?)
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
      'avatar': avatar,
      'postedResources':
          postedResources?.map((resource) => resource.toMap()).toList(),
      'savedResources':
          savedResources?.map((resource) => resource.toMap()).toList(),
      'likedResources':
          likedResources?.map((resource) => resource.toMap()).toList(),
      'dislikedResources':
          dislikedResources?.map((resource) => resource.toMap()).toList(),
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
    String? avatar,
    List<ResourceModel>? postedResources,
    List<ResourceModel>? savedResources,
    List<ResourceModel>? likedResources,
    List<ResourceModel>? dislikedResources,
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
      avatar: avatar ?? this.avatar,
      postedResources: postedResources ?? this.postedResources,
      savedResources: savedResources ?? this.savedResources,
      likedResources: likedResources ?? this.likedResources,
      dislikedResources: dislikedResources ?? this.dislikedResources,
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
