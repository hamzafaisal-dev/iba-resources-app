import 'package:cloud_firestore/cloud_firestore.dart';

class Resource {
  const Resource({
    required this.resourceTitle,
    required this.resourceFiles,
    required this.resourceDescription,
    required this.resourceType,
    required this.uploader,
    required this.teacherName,
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

  factory Resource.fromJson(Map<String, dynamic> resourceData) {
    return Resource(
      resourceTitle: resourceData['resourceTitle'],
      resourceFiles: resourceData['resourceFiles'],
      resourceDescription: resourceData['resourceDescription'],
      resourceType: resourceData['resourceType'],
      uploader: resourceData['uploader'],
      teacherName: resourceData['teacherName'],
      relevantFields: resourceData['relevantFields'],
      semester: resourceData['semester'],
      year: resourceData['year'],
      isActive: resourceData['isActive'],
      isDeleted: resourceData['isDeleted'],

      // Firestore converts DateTime to Timestamps, so we need to convert it back to DateTime upon fetching
      createdAt: (resourceData['createdAt'] as Timestamp).toDate(),
      updatedAt: (resourceData['updatedAt'] as Timestamp?)?.toDate(),
    );
  }
}
