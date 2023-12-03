import 'package:cloud_firestore/cloud_firestore.dart';

class Resource {
  const Resource({
    required this.resourceId,
    required this.resourceTitle,
    required this.resourceFiles,
    required this.resourceDescription,
    required this.resourceType,
    required this.uploader,
    required this.courseName,
    required this.teacherName,
    required this.relevantFields,
    required this.semester,
    required this.year,
    required this.likes,
    required this.dislikes,
    required this.reportCount,
    required this.createdAt,
    this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String resourceId;

  final String resourceTitle;
  final String uploader;
  final String teacherName;
  final String courseName;

  final String resourceDescription;
  final String resourceType;

  final List<dynamic>? resourceFiles;

  final List<dynamic>? relevantFields;
  final String semester;
  final String year;

  final int likes;
  final int dislikes;
  final int reportCount;

  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;

  factory Resource.fromJson(Map<String, dynamic> resourceData) {
    return Resource(
      resourceId: resourceData['resourceId'],
      resourceTitle: resourceData['resourceTitle'],
      resourceFiles: resourceData['resourceFiles'],
      resourceDescription: resourceData['resourceDescription'],
      resourceType: resourceData['resourceType'],
      uploader: resourceData['uploader'],
      teacherName: resourceData['teacherName'],
      courseName: resourceData['courseName'],
      relevantFields: resourceData['relevantFields'],
      semester: resourceData['semester'],
      year: resourceData['year'],

      likes: resourceData['likes'],
      dislikes: resourceData['dislikes'],
      reportCount: resourceData['reportCount'],

      isActive: resourceData['isActive'],
      isDeleted: resourceData['isDeleted'],

      // Firestore converts DateTime to Timestamps, so we need to convert it back to DateTime upon fetching
      createdAt: (resourceData['createdAt'] as Timestamp).toDate(),
      updatedAt: (resourceData['updatedAt'] as Timestamp?)?.toDate(),
    );
  }
}
