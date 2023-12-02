// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class Resource {
  const Resource({
    required this.resourceTitle,
    required this.uploader,
    required this.teacherName,
    required this.resourceDescription,
    required this.resourceType,
    required this.resourceFiles,
    required this.relevantFields,
    required this.semester,
    required this.year,
    required this.createdAt,
    this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String resourceTitle;
  final String uploader;
  final String teacherName;
  final String resourceDescription;
  final String resourceType;

  final List<dynamic>? resourceFiles;

  final List<dynamic>? relevantFields;
  final String semester;
  final String year;

  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;

  // factory Resource.fromJson(Map<String, dynamic> resourceData) {
  //   return Resource(
  //     resourceTitle: resourceData['resourceTitle'],
  //     resourceFiles: resourceData['resourceFiles'],
  //     resourceDescription: resourceData['resourceDescription'],
  //     resourceType: resourceData['resourceType'],
  //     uploader: resourceData['uploader'],
  //     teacherName: resourceData['teacherName'],
  //     relevantFields: resourceData['relevantFields'],
  //     semester: resourceData['semester'],
  //     year: resourceData['year'],
  //     isActive: resourceData['isActive'],
  //     isDeleted: resourceData['isDeleted'],

  //     // Firestore converts DateTime to Timestamps, so we need to convert it back to DateTime upon fetching
  //     createdAt: (resourceData['createdAt'] as Timestamp).toDate(),
  //     updatedAt: (resourceData['updatedAt'] as Timestamp?)?.toDate(),
  //   );
  // }

  Resource copyWith({
    String? resourceTitle,
    String? uploader,
    String? teacherName,
    String? resourceDescription,
    String? resourceType,
    List<dynamic>? resourceFiles,
    List<dynamic>? relevantFields,
    String? semester,
    String? year,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isDeleted,
  }) {
    return Resource(
      resourceTitle: resourceTitle ?? this.resourceTitle,
      uploader: uploader ?? this.uploader,
      teacherName: teacherName ?? this.teacherName,
      resourceDescription: resourceDescription ?? this.resourceDescription,
      resourceType: resourceType ?? this.resourceType,
      resourceFiles: resourceFiles ?? this.resourceFiles,
      relevantFields: relevantFields ?? this.relevantFields,
      semester: semester ?? this.semester,
      year: year ?? this.year,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resourceTitle': resourceTitle,
      'uploader': uploader,
      'teacherName': teacherName,
      'resourceDescription': resourceDescription,
      'resourceType': resourceType,
      'resourceFiles': resourceFiles,
      'relevantFields': relevantFields,
      'semester': semester,
      'year': year,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }

  factory Resource.fromMap(Map<String, dynamic> map) {
    return Resource(
      resourceTitle: map['resourceTitle'] as String,
      uploader: map['uploader'] as String,
      teacherName: map['teacherName'] as String,
      resourceDescription: map['resourceDescription'] as String,
      resourceType: map['resourceType'] as String,
      resourceFiles: map['resourceFiles'] != null
          ? List<dynamic>.from((map['resourceFiles'] as List<dynamic>))
          : null,
      relevantFields: map['relevantFields'] != null
          ? List<dynamic>.from((map['relevantFields'] as List<dynamic>))
          : null,
      semester: map['semester'] as String,
      year: map['year'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      isActive: map['isActive'] as bool,
      isDeleted: map['isDeleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Resource.fromJson(String source) =>
      Resource.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Resource(resourceTitle: $resourceTitle, uploader: $uploader, teacherName: $teacherName, resourceDescription: $resourceDescription, resourceType: $resourceType, resourceFiles: $resourceFiles, relevantFields: $relevantFields, semester: $semester, year: $year, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, isDeleted: $isDeleted)';
  }
}
