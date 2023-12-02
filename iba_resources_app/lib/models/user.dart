// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:iba_resources_app/models/resource.dart';

class UserModel {
  const UserModel({
    required this.role,
    required this.name,
    required this.email,
    required this.postedResources,
    required this.savedResources,
    required this.points,
    required this.reportCount,
    required this.isBanned,
    required this.createdAt,
    this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String role;
  final String name;
  final String email;
  final List<Resource>? postedResources;
  final List<Resource>? savedResources;
  final int? points;
  final int? reportCount;
  final bool? isBanned;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;

  UserModel copyWith({
    String? role,
    String? name,
    String? email,
    List<Resource>? postedResources,
    List<Resource>? savedResources,
    int? points,
    int? reportCount,
    bool? isBanned,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isDeleted,
  }) {
    return UserModel(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      role: map['role'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      postedResources: map['postedResources'] != null
          ? List<Resource>.from(
              (map['postedResources'] as List<int>).map<Resource?>(
                (x) => Resource.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      savedResources: map['savedResources'] != null
          ? List<Resource>.from(
              (map['savedResources'] as List<int>).map<Resource?>(
                (x) => Resource.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      points: map['points'] != null ? map['points'] as int : null,
      reportCount:
          map['reportCount'] != null ? map['reportCount'] as int : null,
      isBanned: map['isBanned'] != null ? map['isBanned'] as bool : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      isActive: map['isActive'] as bool,
      isDeleted: map['isDeleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(role: $role, name: $name, email: $email, postedResources: $postedResources, savedResources: $savedResources, points: $points, reportCount: $reportCount, isBanned: $isBanned, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, isDeleted: $isDeleted)';
  }
}
