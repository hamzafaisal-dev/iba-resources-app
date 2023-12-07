// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:iba_resources_app/models/resource.dart';

class UserModel {
  const UserModel({
    required this.role,
    required this.name,
    required this.email,
    // required this.password,
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
  // final String password;
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

      // firestore converts DateTime to Timestamps, so we need to convert it back to DateTime upon fetching
      createdAt: (userData['createdAt'] as Timestamp).toDate(),
      updatedAt: (userData['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
}
